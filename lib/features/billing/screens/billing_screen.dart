import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/utils/mock_data.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/invoice_model.dart';

class BillingScreen extends ConsumerStatefulWidget {
  const BillingScreen({super.key});

  @override
  ConsumerState<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends ConsumerState<BillingScreen> {
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final invoices = MockData.invoices;
    final filtered = invoices.where((i) {
      final searchMatch = _searchQuery.isEmpty ||
          i.patientName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          i.invoiceNumber.toLowerCase().contains(_searchQuery.toLowerCase());
      final statusMatch = _statusFilter == 'All' || (() { final x = i.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })() == _statusFilter;
      return searchMatch && statusMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, AppSpacing.sm, AppSpacing.screenPadding, AppSpacing.sm),
            child: Column(
              children: [
                AppSearchBar(
                  hintText: 'Search invoices...',
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    _buildSummaryCard('Total Revenue', Formatters.compactCurrency(invoices.fold(0, (s, i) => s + i.total.toInt())), AppColors.success),
                    const SizedBox(width: AppSpacing.sm),
                    _buildSummaryCard('Pending', Formatters.compactCurrency(invoices.where((i) => i.status == InvoiceStatus.sent).fold(0, (s, i) => s + i.remainingAmount.toInt())), AppColors.warning),
                    const SizedBox(width: AppSpacing.sm),
                    _buildSummaryCard('Overdue', invoices.where((i) => i.isOverdue).length.toString(), AppColors.danger),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              children: ['All', 'Paid', 'Sent', 'Overdue', 'Draft'].map((s) {
                final isSelected = _statusFilter == s;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: GestureDetector(
                    onTap: () => setState(() => _statusFilter = s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                      ),
                      child: Text(s, style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textGrey,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final invoice = filtered[index];
                return _InvoiceCard(invoice: invoice).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).slideX(begin: 0.05, curve: Curves.easeOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: color)),
            Text(title, style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  const _InvoiceCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/billing/${invoice.id}'),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: _statusColor(invoice.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(Icons.receipt_long_rounded, color: _statusColor(invoice.status), size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(invoice.invoiceNumber, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(invoice.patientName, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                Text(DateFormat('MMM dd, yyyy').format(invoice.issueDate), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textLight, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(Formatters.currency(invoice.total), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: _statusColor(invoice.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text((() { final x = invoice.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(), style: TextStyle(fontSize: 10, color: _statusColor(invoice.status), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.draft: return AppColors.textGrey;
      case InvoiceStatus.sent: return AppColors.primary;
      case InvoiceStatus.paid: return AppColors.success;
      case InvoiceStatus.overdue: return AppColors.danger;
      case InvoiceStatus.cancelled: return AppColors.textGrey;
    }
  }
}
