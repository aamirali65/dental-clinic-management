enum InvoiceStatus { draft, sent, paid, overdue, cancelled }

class InvoiceModel {
  final String id;
  final String invoiceNumber;
  final String patientId;
  final String patientName;
  final List<InvoiceItem> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final double paidAmount;
  final InvoiceStatus status;
  final DateTime issueDate;
  final DateTime dueDate;
  final DateTime? paidDate;
  final String? notes;
  final DateTime createdAt;

  InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    required this.patientId,
    required this.patientName,
    this.items = const [],
    this.subtotal = 0,
    this.tax = 0,
    this.discount = 0,
    this.total = 0,
    this.paidAmount = 0,
    this.status = InvoiceStatus.draft,
    required this.issueDate,
    required this.dueDate,
    this.paidDate,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get remainingAmount => total - paidAmount;
  bool get isOverdue => status == InvoiceStatus.sent && DateTime.now().isAfter(dueDate);
}

class InvoiceItem {
  final String name;
  final String? description;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  InvoiceItem({
    required this.name,
    this.description,
    this.quantity = 1,
    this.unitPrice = 0,
    this.totalPrice = 0,
  });
}
