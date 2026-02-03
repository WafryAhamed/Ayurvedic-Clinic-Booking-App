import '../../domain/entities/doctor.dart';

/// Mock data for Ayurvedic doctors with Sri Lankan names
class MockDoctors {
  static final List<Doctor> doctors = [
    // Doctor 1
    Doctor(
      id: 'doc_001',
      name: 'Dr. Nimal Perera',
      specialization: 'Panchakarma Specialist',
      experienceYears: 15,
      consultationFee: 3500.00,
      rating: 4.8,
      profileImage: '👨‍⚕️',
      bio:
          'Dr. Nimal Perera is a renowned Panchakarma specialist with over 15 years of experience in traditional Ayurvedic detoxification and rejuvenation therapies. He specializes in treating chronic digestive disorders and lifestyle diseases.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'MD (Ayurveda) - Panchakarma',
        'Certified Ayurvedic Practitioner',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Monday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Monday',
          startTime: '02:00 PM',
          endTime: '05:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Friday',
          startTime: '02:00 PM',
          endTime: '06:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '10:00 AM',
          endTime: '01:00 PM',
        ),
      ],
    ),

    // Doctor 2
    Doctor(
      id: 'doc_002',
      name: 'Dr. Sithara Fernando',
      specialization: 'Herbal Medicine Expert',
      experienceYears: 12,
      consultationFee: 3000.00,
      rating: 4.9,
      profileImage: '👩‍⚕️',
      bio:
          'Dr. Sithara Fernando is an expert in Ayurvedic herbal medicine with a focus on women\'s health and wellness. She has extensive knowledge in traditional Sri Lankan Ayurvedic remedies and formulations.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'Diploma in Herbal Medicine',
        'Women\'s Health Specialist',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Tuesday',
          startTime: '08:00 AM',
          endTime: '11:00 AM',
        ),
        const TimeSlot(
          day: 'Tuesday',
          startTime: '03:00 PM',
          endTime: '06:00 PM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '09:00 AM',
          endTime: '01:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '02:00 PM',
          endTime: '05:00 PM',
        ),
      ],
    ),

    // Doctor 3
    Doctor(
      id: 'doc_003',
      name: 'Dr. Chandana Silva',
      specialization: 'General Ayurvedic Physician',
      experienceYears: 20,
      consultationFee: 4000.00,
      rating: 4.7,
      profileImage: '👨‍⚕️',
      bio:
          'Dr. Chandana Silva has been practicing Ayurveda for two decades, specializing in constitutional analysis (Prakriti) and personalized treatment plans. He is known for his holistic approach to health and wellness.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'MD (Ayurveda) - Kayachikitsa',
        'Senior Consultant - 20+ years',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Monday',
          startTime: '08:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '02:00 PM',
          endTime: '06:00 PM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '08:00 AM',
          endTime: '11:00 AM',
        ),
        const TimeSlot(
          day: 'Friday',
          startTime: '09:00 AM',
          endTime: '01:00 PM',
        ),
      ],
    ),

    // Doctor 4
    Doctor(
      id: 'doc_004',
      name: 'Dr. Malini Jayawardena',
      specialization: 'Wellness & Lifestyle Consultant',
      experienceYears: 8,
      consultationFee: 2500.00,
      rating: 4.6,
      profileImage: '👩‍⚕️',
      bio:
          'Dr. Malini Jayawardena specializes in Ayurvedic lifestyle counseling, yoga therapy, and stress management. She helps patients achieve balance through diet, exercise, and traditional Ayurvedic practices.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'Yoga Therapy Certification',
        'Lifestyle Disease Management',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Monday',
          startTime: '03:00 PM',
          endTime: '07:00 PM',
        ),
        const TimeSlot(
          day: 'Tuesday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '10:00 AM',
          endTime: '01:00 PM',
        ),
        const TimeSlot(
          day: 'Friday',
          startTime: '02:00 PM',
          endTime: '05:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
      ],
    ),

    // Doctor 5
    Doctor(
      id: 'doc_005',
      name: 'Dr. Kamal Dissanayake',
      specialization: 'Traditional Ayurvedic Therapist',
      experienceYears: 18,
      consultationFee: 3800.00,
      rating: 4.9,
      profileImage: '👨‍⚕️',
      bio:
          'Dr. Kamal Dissanayake is a master of traditional Ayurvedic therapeutic techniques including Abhyanga, Shirodhara, and various massage therapies. He specializes in pain management and musculoskeletal disorders.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'Advanced Diploma in Ayurvedic Therapies',
        'Pain Management Specialist',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Tuesday',
          startTime: '08:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '08:00 AM',
          endTime: '11:00 AM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '02:00 PM',
          endTime: '06:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '08:00 AM',
          endTime: '02:00 PM',
        ),
      ],
    ),

    // Doctor 6
    Doctor(
      id: 'doc_006',
      name: 'Dr. Priyanka Rajapaksa',
      specialization: 'Ayurvedic Dermatologist',
      experienceYears: 10,
      consultationFee: 3200.00,
      rating: 4.8,
      profileImage: '👩‍⚕️',
      bio:
          'Dr. Priyanka Rajapaksa specializes in Ayurvedic dermatology and beauty care. She treats various skin conditions using natural herbal remedies and traditional Ayurvedic techniques for skin rejuvenation.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'MD (Ayurveda) - Shalakya Tantra',
        'Skin & Beauty Care Specialist',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Monday',
          startTime: '10:00 AM',
          endTime: '01:00 PM',
        ),
        const TimeSlot(
          day: 'Tuesday',
          startTime: '02:00 PM',
          endTime: '05:00 PM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Friday',
          startTime: '10:00 AM',
          endTime: '02:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '03:00 PM',
          endTime: '06:00 PM',
        ),
      ],
    ),

    // Doctor 7
    Doctor(
      id: 'doc_007',
      name: 'Dr. Ruwan Gunasekara',
      specialization: 'Ayurvedic Nutritionist',
      experienceYears: 7,
      consultationFee: 2800.00,
      rating: 4.5,
      profileImage: '👨‍⚕️',
      bio:
          'Dr. Ruwan Gunasekara focuses on Ayurvedic nutrition and dietary planning based on individual body constitutions. He helps patients manage weight, diabetes, and other metabolic disorders through personalized diet plans.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'PG Diploma in Ayurvedic Nutrition',
        'Metabolic Disorder Specialist',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Monday',
          startTime: '09:00 AM',
          endTime: '01:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '03:00 PM',
          endTime: '07:00 PM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '10:00 AM',
          endTime: '01:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '09:00 AM',
          endTime: '11:00 AM',
        ),
      ],
    ),

    // Doctor 8
    Doctor(
      id: 'doc_008',
      name: 'Dr. Dilini Wijesinghe',
      specialization: 'Pediatric Ayurveda Specialist',
      experienceYears: 11,
      consultationFee: 3300.00,
      rating: 4.9,
      profileImage: '👩‍⚕️',
      bio:
          'Dr. Dilini Wijesinghe specializes in Ayurvedic pediatrics, focusing on children\'s health, growth, and immunity. She uses gentle, natural remedies to treat common childhood ailments and boost overall vitality.',
      qualifications: [
        'BAMS - Bachelor of Ayurvedic Medicine and Surgery',
        'Fellowship in Pediatric Ayurveda',
        'Child Health & Immunity Expert',
      ],
      availableSlots: [
        const TimeSlot(
          day: 'Tuesday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Wednesday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Thursday',
          startTime: '03:00 PM',
          endTime: '06:00 PM',
        ),
        const TimeSlot(
          day: 'Friday',
          startTime: '09:00 AM',
          endTime: '12:00 PM',
        ),
        const TimeSlot(
          day: 'Saturday',
          startTime: '10:00 AM',
          endTime: '02:00 PM',
        ),
      ],
    ),
  ];

  /// Get all mock doctors
  static List<Doctor> getAllDoctors() {
    return List.unmodifiable(doctors);
  }

  /// Get specific doctor by ID
  static Doctor? getDoctorById(String id) {
    try {
      return doctors.firstWhere((doctor) => doctor.id == id);
    } catch (e) {
      return null;
    }
  }
}
