class DoctorModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String specialization;
  final String? qualification;
  final int experience;
  final double rating;
  final int reviewCount;
  final String? avatarUrl;
  final List<String> services;
  final Map<String, List<String>> workingHours;
  final bool isAvailable;
  final double consultationFee;
  final String? about;
  final List<String> languages;
  final bool isActive;

  DoctorModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.specialization,
    this.qualification,
    this.experience = 0,
    this.rating = 0,
    this.reviewCount = 0,
    this.avatarUrl,
    this.services = const [],
    this.workingHours = const {},
    this.isAvailable = true,
    this.consultationFee = 0,
    this.about,
    this.languages = const [],
    this.isActive = true,
  });

  String get initials {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return fullName[0].toUpperCase();
  }

  String get experienceText => '$experience ${experience == 1 ? 'year' : 'years'}';
}
