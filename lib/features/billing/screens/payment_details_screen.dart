import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/mock_data.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/invoice_model.dart';

class PaymentDetailsScreen extends ConsumerWidget {
  final String invoiceId;

  const PaymentDetailsScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoice = MockData.invoices.firstWhere(
      (i) => i.id == invoiceId,
      orElse: () => MockData.invoices.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, invoice),
            const SizedBox(height: AppSpacing.xxl),
            _buildPatientInfo(context, invoice),
            const SizedBox(height: AppSpacing.xl),
            _buildItems(context, invoice),
            const SizedBox(height: AppSpacing.xl),
            _buildSummary(context, invoice),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: 'Mark as Paid',
              onPressed: () {},
              isFullWidth: true,
              isLarge: true,
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: 'Send Reminder',
              isOutlined: true,
              onPressed: () {},
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, InvoiceModel invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: _statusColor(invoice.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
          ),
            child: Text((() { final x = invoice.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })(), style: TextStyle(color: _statusColor(invoice.status), fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(invoice.invoiceNumber, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSpacing.xs),
        Text('Issued: ${DateFormat('MMM dd, yyyy').format(invoice.issueDate)}', style: TextStyle(color: AppColors.textGrey)),
        Text('Due: ${DateFormat('MMM dd, yyyy').format(invoice.dueDate)}', style: TextStyle(color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildPatientInfo(BuildContext context, InvoiceModel invoice) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(invoice.patientName, style: TextStyle(fontWeight: FontWeight.w600)),
                Text('Patient', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context, InvoiceModel invoice) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.md),
          ...invoice.items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('${item.quantity}x', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    ],
                  ),
                ),
                Text(Formatters.currency(item.totalPrice), style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, InvoiceModel invoice) {
    return AppCard(
      child: Column(
        children: [
          _SummaryRow(label: 'Subtotal', value: Formatters.currency(invoice.subtotal)),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Tax (8%)', value: Formatters.currency(invoice.tax)),
          const SizedBox(height: AppSpacing.sm),
          if (invoice.discount > 0)
            _SummaryRow(label: 'Discount', value: '-${Formatters.currency(invoice.discount)}', color: AppColors.success),
          if (invoice.discount > 0) const SizedBox(height: AppSpacing.sm),
          const Divider(),
          _SummaryRow(label: 'Total', value: Formatters.currency(invoice.total), isBold: true),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Paid', value: Formatters.currency(invoice.paidAmount), color: AppColors.success),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: 'Balance', value: Formatters.currency(invoice.remainingAmount), color: AppColors.warning, isBold: true),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;

  const _SummaryRow({required this.label, required this.value, this.isBold = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: color ?? AppColors.textGrey, fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
        Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w600, color: color)),
      ],
    );
  }
}
