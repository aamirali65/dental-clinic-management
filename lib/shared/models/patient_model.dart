enum Gender { male, female, other }
enum BloodType { aPositive, aNegative, bPositive, bNegative, oPositive, oNegative, abPositive, abNegative }

class PatientModel {
  final String id;
  final String fullName;
  final String? email;
  final String phone;
  final Gender gender;
  final DateTime dateOfBirth;
  final String? address;
  final String? avatarUrl;
  final BloodType? bloodType;
  final List<String> allergies;
  final List<String> medicalConditions;
  final List<String> medications;
  final String? emergencyContact;
  final String? emergencyPhone;
  final String? insuranceProvider;
  final String? insuranceNumber;
  final String? notes;
  final DateTime registeredAt;
  final DateTime lastVisit;
  final int totalVisits;
  final bool isActive;

  PatientModel({
    required this.id,
    required this.fullName,
    this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    this.address,
    this.avatarUrl,
    this.bloodType,
    this.allergies = const [],
    this.medicalConditions = const [],
    this.medications = const [],
    this.emergencyContact,
    this.emergencyPhone,
    this.insuranceProvider,
    this.insuranceNumber,
    this.notes,
    DateTime? registeredAt,
    DateTime? lastVisit,
    this.totalVisits = 0,
    this.isActive = true,
  })  : registeredAt = registeredAt ?? DateTime.now(),
        lastVisit = lastVisit ?? DateTime.now();

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String get initials {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return fullName[0].toUpperCase();
  }
}
