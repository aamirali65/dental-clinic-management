enum TreatmentStatus { notStarted, inProgress, completed, cancelled }
enum TreatmentCategory { general, cosmetic, orthodontic, surgical, periodontal, endodontic }

class TreatmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String name;
  final String? description;
  final TreatmentCategory category;
  final TreatmentStatus status;
  final double cost;
  final double paidAmount;
  final DateTime startDate;
  final DateTime? endDate;
  final int sessionsTotal;
  final int sessionsCompleted;
  final List<String> notes;
  final List<String> prescriptionIds;
  final List<String> imageUrls;
  final DateTime createdAt;

  TreatmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.name,
    this.description,
    required this.category,
    this.status = TreatmentStatus.notStarted,
    this.cost = 0,
    this.paidAmount = 0,
    required this.startDate,
    this.endDate,
    this.sessionsTotal = 1,
    this.sessionsCompleted = 0,
    this.notes = const [],
    this.prescriptionIds = const [],
    this.imageUrls = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get progress => sessionsTotal > 0 ? sessionsCompleted / sessionsTotal : 0;
  double get remainingAmount => cost - paidAmount;
  bool get isFullyPaid => paidAmount >= cost;
}
