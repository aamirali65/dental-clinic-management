enum PaymentMethod { cash, card, insurance, bankTransfer, online }
enum PaymentStatus { pending, completed, failed, refunded }

class PaymentModel {
  final String id;
  final String invoiceId;
  final String patientId;
  final String patientName;
  final double amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime date;
  final String? transactionId;
  final String? notes;
  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.invoiceId,
    required this.patientId,
    required this.patientName,
    required this.amount,
    required this.method,
    this.status = PaymentStatus.pending,
    required this.date,
    this.transactionId,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
