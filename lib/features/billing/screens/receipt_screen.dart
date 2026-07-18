import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/mock_data.dart';
import '../../../core/utils/formatters.dart';

class ReceiptScreen extends ConsumerWidget {
  final String paymentId;

  const ReceiptScreen({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = MockData.payments.firstWhere(
      (p) => p.id == paymentId,
      orElse: () => MockData.payments.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          children: [
            const Icon(Icons.check_circle_rounded, size: 72, color: AppColors.success),
            const SizedBox(height: AppSpacing.lg),
            const Text('Payment Successful', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.sm),
            Text(Formatters.currency(payment.amount), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.xxl),
            AppCard(
              child: Column(
                children: [
                  _ReceiptRow(label: 'Transaction ID', value: payment.transactionId ?? 'N/A'),
                  const Divider(height: AppSpacing.xxl),
                  _ReceiptRow(label: 'Payment Method', value: (() { final x = payment.method.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()),
                  const Divider(height: AppSpacing.xxl),
                  _ReceiptRow(label: 'Status', value: (() { final x = payment.status.name; return '${x[0].toUpperCase()}${x.substring(1)}'; })()),
                  const Divider(height: AppSpacing.xxl),
                  _ReceiptRow(label: 'Date', value: DateFormat('MMM dd, yyyy').format(payment.date)),
                  const Divider(height: AppSpacing.xxl),
                  _ReceiptRow(label: 'Patient', value: payment.patientName),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: 'Download Receipt',
              onPressed: () {},
              isFullWidth: true,
              icon: Icons.download_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReceiptRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColors.textGrey)),
        Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
