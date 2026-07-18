enum AppointmentStatus { scheduled, confirmed, inProgress, completed, cancelled, noShow }
enum AppointmentType { consultation, checkup, cleaning, filling, rootCanal, extraction, whitening, orthodontic, surgery, emergency }

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String? patientAvatar;
  final String doctorId;
  final String doctorName;
  final String? doctorAvatar;
  final AppointmentType type;
  final AppointmentStatus status;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final String? treatmentId;
  final double? amount;
  final bool isPaid;
  final String? location;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    this.patientAvatar,
    required this.doctorId,
    required this.doctorName,
    this.doctorAvatar,
    required this.type,
    this.status = AppointmentStatus.scheduled,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.treatmentId,
    this.amount,
    this.isPaid = false,
    this.location,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Duration get duration => endTime.difference(startTime);

  bool get isUpcoming => status == AppointmentStatus.scheduled || status == AppointmentStatus.confirmed;
  bool get isPast => date.isBefore(DateTime.now()) && status != AppointmentStatus.completed;
}
