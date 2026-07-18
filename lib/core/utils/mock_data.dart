import 'package:collection/collection.dart';
import '../../shared/models/user_model.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/models/doctor_model.dart';
import '../../shared/models/appointment_model.dart';
import '../../shared/models/treatment_model.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/models/payment_model.dart';
import '../../shared/models/notification_model.dart';

class MockData {
  MockData._();

  static final UserModel currentUser = UserModel(
    id: 'usr_001',
    email: 'dr.sarah@dentflow.com',
    fullName: 'Dr. Sarah Chen',
    phone: '+1 (555) 123-4567',
    role: UserRole.admin,
    specialization: 'Orthodontics',
    avatarUrl: null,
  );

  static final List<DoctorModel> doctors = [
    DoctorModel(
      id: 'doc_001',
      fullName: 'Dr. Sarah Chen',
      email: 'sarah@dentflow.com',
      phone: '+1 (555) 111-0001',
      specialization: 'Orthodontics',
      qualification: 'DDS, MS - Orthodontics',
      experience: 12,
      rating: 4.9,
      reviewCount: 328,
      isAvailable: true,
      consultationFee: 150,
      languages: ['English', 'Mandarin'],
      about: 'Dr. Sarah Chen is a board-certified orthodontist with over 12 years of experience...',
      services: ['Braces', 'Invisalign', 'Retainers', 'Orthodontic Surgery'],
      workingHours: {
        'Monday': ['09:00', '17:00'],
        'Tuesday': ['09:00', '17:00'],
        'Wednesday': ['09:00', '17:00'],
        'Thursday': ['09:00', '17:00'],
        'Friday': ['09:00', '15:00'],
      },
    ),
    DoctorModel(
      id: 'doc_002',
      fullName: 'Dr. James Wilson',
      email: 'james@dentflow.com',
      phone: '+1 (555) 111-0002',
      specialization: 'Oral Surgery',
      qualification: 'DDS, MD - Oral Surgery',
      experience: 15,
      rating: 4.8,
      reviewCount: 256,
      isAvailable: true,
      consultationFee: 200,
      languages: ['English', 'Spanish'],
      about: 'Dr. James Wilson is an experienced oral surgeon specializing in complex dental surgeries...',
      services: ['Wisdom Teeth Removal', 'Dental Implants', 'Jaw Surgery', 'Bone Grafting'],
      workingHours: {
        'Monday': ['10:00', '18:00'],
        'Tuesday': ['10:00', '18:00'],
        'Wednesday': ['10:00', '18:00'],
        'Thursday': ['10:00', '18:00'],
        'Friday': ['10:00', '16:00'],
      },
    ),
    DoctorModel(
      id: 'doc_003',
      fullName: 'Dr. Emily Rodriguez',
      email: 'emily@dentflow.com',
      phone: '+1 (555) 111-0003',
      specialization: 'Cosmetic Dentistry',
      qualification: 'DDS, AAACD',
      experience: 10,
      rating: 4.9,
      reviewCount: 412,
      isAvailable: true,
      consultationFee: 175,
      languages: ['English', 'French'],
      about: 'Dr. Emily Rodriguez is a leading cosmetic dentist known for creating beautiful smiles...',
      services: ['Teeth Whitening', 'Veneers', 'Smile Makeover', 'Composite Bonding'],
      workingHours: {
        'Monday': ['08:00', '16:00'],
        'Tuesday': ['08:00', '16:00'],
        'Wednesday': ['08:00', '16:00'],
        'Thursday': ['08:00', '16:00'],
        'Friday': ['08:00', '14:00'],
      },
    ),
    DoctorModel(
      id: 'doc_004',
      fullName: 'Dr. Michael Park',
      email: 'michael@dentflow.com',
      phone: '+1 (555) 111-0004',
      specialization: 'Periodontics',
      qualification: 'DDS, MS - Periodontics',
      experience: 8,
      rating: 4.7,
      reviewCount: 189,
      isAvailable: true,
      consultationFee: 130,
      languages: ['English', 'Korean'],
      about: 'Dr. Michael Park specializes in gum health and dental implant procedures...',
      services: ['Gum Treatment', 'Scaling', 'Root Planing', 'Gum Surgery'],
      workingHours: {
        'Monday': ['09:00', '17:00'],
        'Tuesday': ['09:00', '17:00'],
        'Wednesday': ['09:00', '17:00'],
        'Thursday': ['09:00', '17:00'],
        'Friday': ['09:00', '15:00'],
      },
    ),
    DoctorModel(
      id: 'doc_005',
      fullName: 'Dr. Lisa Thompson',
      email: 'lisa@dentflow.com',
      phone: '+1 (555) 111-0005',
      specialization: 'Pediatric Dentistry',
      qualification: 'DDS, MS - Pediatric Dentistry',
      experience: 9,
      rating: 4.9,
      reviewCount: 375,
      isAvailable: false,
      consultationFee: 140,
      languages: ['English'],
      about: 'Dr. Lisa Thompson makes dental visits fun and comfortable for children...',
      services: ['Child Checkups', 'Fluoride Treatment', 'Sealants', 'Child Braces'],
      workingHours: {
        'Monday': ['08:00', '16:00'],
        'Tuesday': ['08:00', '16:00'],
        'Wednesday': ['08:00', '16:00'],
        'Thursday': ['08:00', '16:00'],
        'Friday': ['08:00', '14:00'],
      },
    ),
    DoctorModel(
      id: 'doc_006',
      fullName: 'Dr. Robert Kim',
      email: 'robert@dentflow.com',
      phone: '+1 (555) 111-0006',
      specialization: 'Endodontics',
      qualification: 'DDS, MS - Endodontics',
      experience: 14,
      rating: 4.8,
      reviewCount: 298,
      isAvailable: true,
      consultationFee: 190,
      languages: ['English', 'Korean'],
      about: 'Dr. Robert Kim is a specialist in root canal treatments and dental pain management...',
      services: ['Root Canal', 'Endodontic Surgery', 'Dental Trauma', 'Microsurgery'],
      workingHours: {
        'Monday': ['09:00', '17:00'],
        'Tuesday': ['09:00', '17:00'],
        'Wednesday': ['09:00', '17:00'],
        'Thursday': ['09:00', '17:00'],
        'Friday': ['09:00', '15:00'],
      },
    ),
    DoctorModel(
      id: 'doc_007',
      fullName: 'Dr. Maria Garcia',
      email: 'maria@dentflow.com',
      phone: '+1 (555) 111-0007',
      specialization: 'Prosthodontics',
      qualification: 'DDS, MS - Prosthodontics',
      experience: 11,
      rating: 4.8,
      reviewCount: 234,
      isAvailable: true,
      consultationFee: 160,
      languages: ['English', 'Spanish'],
      about: 'Dr. Maria Garcia restores smiles with custom dental prosthetics...',
      services: ['Crowns', 'Bridges', 'Dentures', 'Full Mouth Reconstruction'],
      workingHours: {
        'Monday': ['09:00', '17:00'],
        'Tuesday': ['09:00', '17:00'],
        'Wednesday': ['09:00', '17:00'],
        'Thursday': ['09:00', '17:00'],
        'Friday': ['09:00', '15:00'],
      },
    ),
    DoctorModel(
      id: 'doc_008',
      fullName: 'Dr. David Martinez',
      email: 'david@dentflow.com',
      phone: '+1 (555) 111-0008',
      specialization: 'General Dentistry',
      qualification: 'DDS',
      experience: 7,
      rating: 4.7,
      reviewCount: 167,
      isAvailable: true,
      consultationFee: 100,
      languages: ['English', 'Spanish'],
      about: 'Dr. David Martinez provides comprehensive general dental care for the whole family...',
      services: ['Checkups', 'Fillings', 'Cleanings', 'Extractions'],
      workingHours: {
        'Monday': ['08:00', '18:00'],
        'Tuesday': ['08:00', '18:00'],
        'Wednesday': ['08:00', '18:00'],
        'Thursday': ['08:00', '18:00'],
        'Friday': ['08:00', '17:00'],
        'Saturday': ['09:00', '13:00'],
      },
    ),
    DoctorModel(
      id: 'doc_009',
      fullName: 'Dr. Jennifer Lee',
      email: 'jennifer@dentflow.com',
      phone: '+1 (555) 111-0009',
      specialization: 'Orthodontics',
      qualification: 'DDS, MS - Orthodontics',
      experience: 6,
      rating: 4.6,
      reviewCount: 145,
      isAvailable: true,
      consultationFee: 135,
      languages: ['English', 'Mandarin'],
      about: 'Dr. Jennifer Lee creates perfectly aligned smiles with modern orthodontic techniques...',
      services: ['Braces', 'Invisalign', 'Retainers', 'Early Intervention'],
      workingHours: {
        'Monday': ['10:00', '18:00'],
        'Tuesday': ['10:00', '18:00'],
        'Wednesday': ['10:00', '18:00'],
        'Thursday': ['10:00', '18:00'],
        'Friday': ['10:00', '16:00'],
      },
    ),
    DoctorModel(
      id: 'doc_010',
      fullName: 'Dr. William Brown',
      email: 'william@dentflow.com',
      phone: '+1 (555) 111-0010',
      specialization: 'Oral Surgery',
      qualification: 'DDS, MD - Oral Surgery',
      experience: 18,
      rating: 4.9,
      reviewCount: 456,
      isAvailable: true,
      consultationFee: 250,
      languages: ['English'],
      about: 'Dr. William Brown is a senior oral surgeon with expertise in complex surgical cases...',
      services: ['Wisdom Teeth', 'Implants', 'Jaw Surgery', 'Facial Trauma'],
      workingHours: {
        'Monday': ['09:00', '17:00'],
        'Tuesday': ['09:00', '17:00'],
        'Wednesday': ['09:00', '17:00'],
        'Thursday': ['09:00', '17:00'],
        'Friday': ['09:00', '15:00'],
      },
    ),
  ];

  static final List<PatientModel> patients = List.generate(50, (i) {
    final names = [
      'Emma Johnson', 'Liam Smith', 'Olivia Williams', 'Noah Brown', 'Ava Jones',
      'Ethan Garcia', 'Sophia Miller', 'Mason Davis', 'Isabella Rodriguez', 'Logan Martinez',
      'Mia Hernandez', 'Lucas Lopez', 'Charlotte Gonzalez', 'James Wilson', 'Amber Anderson',
      'Benjamin Thomas', 'Harper Taylor', 'Elijah Moore', 'Evelyn Jackson', 'Alexander Martin',
      'Abigail Lee', 'Daniel Perez', 'Emily White', 'Matthew Harris', 'Ella Clark',
      'Henry Lewis', 'Avery Robinson', 'Sebastian Walker', 'Scarlett Young', 'Jack Allen',
      'Grace King', 'Owen Wright', 'Chloe Scott', 'Samuel Green', 'Lily Baker',
      'David Adams', 'Nora Nelson', 'Joseph Hill', 'Zoey Campbell', 'Carter Mitchell',
      'Penelope Roberts', 'Wyatt Turner', 'Layla Phillips', 'John Campbell', 'Riley Parker',
      'Luke Evans', 'Eleanor Edwards', 'Gabriel Collins', 'Hannah Stewart', 'Isaac Morris',
    ];
    final genders = [Gender.male, Gender.female];
    final bloodTypes = [BloodType.aPositive, BloodType.aNegative, BloodType.bPositive, BloodType.oPositive, BloodType.oNegative, BloodType.abPositive];
    final age = 5 + (i * 1.3).floor();
    final year = DateTime.now().year - age;
    return PatientModel(
      id: 'pat_${(i + 1).toString().padLeft(3, '0')}',
      fullName: names[i],
      email: '${names[i].toLowerCase().replaceAll(' ', '.')}@email.com',
      phone: '+1 (555) ${(100 + i * 17).toString().padLeft(3, '0')}-${(1000 + i * 37).toString().padLeft(4, '0')}',
      gender: genders[i % 2],
      dateOfBirth: DateTime(year, 1 + (i % 12), 1 + (i % 28)),
      address: '${100 + i * 7} Main Street, Suite ${200 + i}',
      bloodType: bloodTypes[i % bloodTypes.length],
      allergies: i % 3 == 0 ? ['Penicillin', 'Latex'] : [],
      medicalConditions: i % 4 == 0 ? ['Hypertension', 'Diabetes Type 2'] : i % 5 == 0 ? ['Asthma'] : [],
      medications: i % 6 == 0 ? ['Metformin', 'Lisinopril'] : [],
      emergencyContact: 'John ${names[i].split(' ').last}',
      emergencyPhone: '+1 (555) ${(900 + i * 13).toString().padLeft(3, '0')}-${(5000 + i * 23).toString().padLeft(4, '0')}',
      insuranceProvider: i % 2 == 0 ? 'Delta Dental' : 'Cigna',
      insuranceNumber: 'DEN-${(1000000 + i * 1234).toString()}',
      totalVisits: 1 + (i * 2.5).floor(),
      registeredAt: DateTime.now().subtract(Duration(days: 30 + i * 15)),
      lastVisit: DateTime.now().subtract(Duration(days: i * 3)),
    );
  });

  static final List<AppointmentModel> appointments = List.generate(300, (i) {
    final types = AppointmentType.values;
    final patient = patients[i % patients.length];
    final doctor = doctors[i % doctors.length];
    final dayOffset = (i / 5).floor();
    final hour = 8 + (i % 8);
    final date = DateTime.now().subtract(Duration(days: 15 - dayOffset));
    final startTime = DateTime(date.year, date.month, date.day, hour, (i % 4) * 15);
    final endTime = startTime.add(Duration(minutes: 30 + (i % 4) * 15));
    final status = i < 10
        ? AppointmentStatus.scheduled
        : i < 20
            ? AppointmentStatus.confirmed
            : i < 200
                ? AppointmentStatus.completed
                : i < 250
                    ? AppointmentStatus.cancelled
                    : AppointmentStatus.noShow;
    return AppointmentModel(
      id: 'apt_${(i + 1).toString().padLeft(3, '0')}',
      patientId: patient.id,
      patientName: patient.fullName,
      doctorId: doctor.id,
      doctorName: doctor.fullName,
      doctorAvatar: null,
      type: types[i % types.length],
      status: status,
      date: date,
      startTime: startTime,
      endTime: endTime,
      notes: i % 5 == 0 ? 'Patient requested numbing gel' : null,
      amount: 75.0 + (i % 10) * 25.0,
      isPaid: i % 3 != 0,
      location: 'Room ${100 + (i % 8)}',
    );
  });

  static final List<TreatmentModel> treatments = List.generate(30, (i) {
    final patient = patients[i % patients.length];
    final doctor = doctors[i % doctors.length];
    final categories = TreatmentCategory.values;
    final statuses = TreatmentStatus.values;
    final treatmentNames = [
      'Full Mouth Restoration', 'Invisalign Treatment', 'Dental Implants',
      'Root Canal Therapy', 'Teeth Whitening', 'Porcelain Veneers',
      'Braces Treatment', 'Gum Surgery', 'Wisdom Teeth Removal',
      'Dental Crowns', 'Smile Makeover', 'Periodontal Treatment',
      'Bone Grafting', 'Denture Fitting', 'Composite Bonding',
    ];
    return TreatmentModel(
      id: 'trt_${(i + 1).toString().padLeft(3, '0')}',
      patientId: patient.id,
      patientName: patient.fullName,
      doctorId: doctor.id,
      doctorName: doctor.fullName,
      name: treatmentNames[i % treatmentNames.length],
      description: 'Comprehensive treatment plan for ${patient.fullName}',
      category: categories[i % categories.length],
      status: statuses[i % statuses.length],
      cost: 500.0 + (i * 150.0),
      paidAmount: i % 2 == 0 ? 500.0 + (i * 150.0) : 200.0 + (i * 50.0),
      startDate: DateTime.now().subtract(Duration(days: 30 + i * 5)),
      endDate: i % 3 == 0 ? DateTime.now().add(Duration(days: 30 + i * 5)) : null,
      sessionsTotal: 3 + (i % 8),
      sessionsCompleted: i % 2 == 0 ? 3 + (i % 8) : (i % 4),
    );
  });

  static final List<InvoiceModel> invoices = List.generate(40, (i) {
    final patient = patients[i % patients.length];
    final statuses = InvoiceStatus.values;
    final items = [
      InvoiceItem(name: 'Consultation', quantity: 1, unitPrice: 100.0, totalPrice: 100.0),
      InvoiceItem(name: 'X-Ray', quantity: 1, unitPrice: 75.0, totalPrice: 75.0),
      InvoiceItem(name: 'Treatment Fee', quantity: 1, unitPrice: 300.0 + i * 50.0, totalPrice: 300.0 + i * 50.0),
    ];
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final tax = subtotal * 0.08;
    final total = subtotal + tax;
    return InvoiceModel(
      id: 'inv_${(i + 1).toString().padLeft(3, '0')}',
      invoiceNumber: 'INV-${2024000 + i}',
      patientId: patient.id,
      patientName: patient.fullName,
      items: items,
      subtotal: subtotal,
      tax: tax,
      discount: i % 5 == 0 ? 50.0 : 0,
      total: total - (i % 5 == 0 ? 50.0 : 0),
      paidAmount: i % 2 == 0 ? total : 0,
      status: statuses[i % statuses.length],
      issueDate: DateTime.now().subtract(Duration(days: 30 + i * 2)),
      dueDate: DateTime.now().add(Duration(days: 15 - i * 2)),
      paidDate: i % 2 == 0 ? DateTime.now().subtract(Duration(days: 15 + i * 2)) : null,
    );
  });

  static final List<PaymentModel> payments = List.generate(40, (i) {
    final patient = patients[i % patients.length];
    final methods = PaymentMethod.values;
    return PaymentModel(
      id: 'pay_${(i + 1).toString().padLeft(3, '0')}',
      invoiceId: invoices[i % invoices.length].id,
      patientId: patient.id,
      patientName: patient.fullName,
      amount: 100.0 + (i * 25.0),
      method: methods[i % methods.length],
      status: i % 5 == 0 ? PaymentStatus.refunded : PaymentStatus.completed,
      date: DateTime.now().subtract(Duration(days: 30 + i * 2)),
      transactionId: 'TXN-${(100000 + i * 789).toString()}',
    );
  });

  static final List<NotificationModel> notifications = List.generate(30, (i) {
    final types = NotificationType.values;
    final priorities = NotificationPriority.values;
    final titles = [
      'Appointment Confirmed', 'Payment Received', 'Treatment Started',
      'New Patient Registered', 'Appointment Reminder', 'Invoice Generated',
      'Lab Results Ready', 'Prescription Refill', 'Follow-up Required',
      'Insurance Verified',
    ];
    final bodies = [
      'Your appointment with ${doctors[i % doctors.length].fullName} has been confirmed.',
      'Payment of \$${(100 + i * 25).toString()} received from ${patients[i % patients.length].fullName}.',
      'Treatment plan for ${patients[i % patients.length].fullName} has been started.',
      'New patient ${patients[i % patients.length].fullName} has registered at your clinic.',
      'Reminder: You have an appointment tomorrow at ${8 + (i % 8)}:00 AM.',
      'Invoice INV-${2024000 + i} has been generated for ${patients[i % patients.length].fullName}.',
      'Lab results are ready for review for ${patients[i % patients.length].fullName}.',
      'Prescription refill request received from ${patients[i % patients.length].fullName}.',
      'Follow-up appointment is required for ${patients[i % patients.length].fullName}.',
      'Insurance verification completed for ${patients[i % patients.length].fullName}.',
    ];
    return NotificationModel(
      id: 'not_${(i + 1).toString().padLeft(3, '0')}',
      title: titles[i % titles.length],
      body: bodies[i % bodies.length],
      type: types[i % types.length],
      priority: priorities[i % priorities.length],
      isRead: i > 10,
      createdAt: DateTime.now().subtract(Duration(hours: i * 4)),
    );
  });

  static List<AppointmentModel> get upcomingAppointments {
    final now = DateTime.now();
    return appointments
        .where((a) => a.date.isAfter(now.subtract(const Duration(hours: 1))) && a.isUpcoming)
        .sorted((a, b) => a.date.compareTo(b.date))
        .take(10)
        .toList();
  }

  static List<AppointmentModel> get todayAppointments {
    final now = DateTime.now();
    return appointments
        .where((a) => a.date.year == now.year && a.date.month == now.month && a.date.day == now.day)
        .sorted((a, b) => a.startTime.compareTo(b.startTime))
        .toList();
  }

  static int get todayRevenue {
    return todayAppointments
        .where((a) => a.isPaid && a.status == AppointmentStatus.completed)
        .fold(0, (sum, a) => sum + (a.amount?.toInt() ?? 0));
  }

  static int get totalPatients => patients.where((p) => p.isActive).length;
  static int get totalDoctors => doctors.where((d) => d.isActive).length;
  static int get todayAppointmentsCount => todayAppointments.length;

  static Map<String, int> get revenueByMonth {
    final data = <String, int>{};
    for (int i = 5; i >= 0; i--) {
      final month = DateTime.now().subtract(Duration(days: 30 * i));
      final key = '${month.month}/${month.year.toString().substring(2)}';
      data[key] = 5000 + (i * 3000) + (i * 1500);
    }
    return data;
  }

  static Map<String, int> get appointmentsByMonth {
    final data = <String, int>{};
    for (int i = 5; i >= 0; i--) {
      final month = DateTime.now().subtract(Duration(days: 30 * i));
      final key = '${month.month}/${month.year.toString().substring(2)}';
      data[key] = 20 + (i * 15) + (i * 5);
    }
    return data;
  }

  static Map<String, double> get treatmentStats {
    return {
      'Completed': treatments.where((t) => t.status == TreatmentStatus.completed).length.toDouble(),
      'In Progress': treatments.where((t) => t.status == TreatmentStatus.inProgress).length.toDouble(),
      'Not Started': treatments.where((t) => t.status == TreatmentStatus.notStarted).length.toDouble(),
      'Cancelled': treatments.where((t) => t.status == TreatmentStatus.cancelled).length.toDouble(),
    };
  }

  static List<AppointmentModel> appointmentsByDoctor(String doctorId) {
    return appointments.where((a) => a.doctorId == doctorId).toList();
  }

  static List<AppointmentModel> appointmentsByPatient(String patientId) {
    return appointments.where((a) => a.patientId == patientId).toList();
  }

  static List<TreatmentModel> treatmentsByPatient(String patientId) {
    return treatments.where((t) => t.patientId == patientId).toList();
  }

  static List<InvoiceModel> invoicesByPatient(String patientId) {
    return invoices.where((i) => i.patientId == patientId).toList();
  }
}
