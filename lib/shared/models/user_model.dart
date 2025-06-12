// User Model
class User {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserProfile? profile;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      profile: json['profile'] != null 
          ? UserProfile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'profile': profile?.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserProfile? profile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profile: profile ?? this.profile,
    );
  }
}

// User Profile Model
class UserProfile {
  final String userId;
  final int age;
  final String gender;
  final double height; // cm
  final double weight; // kg
  final String activityLevel;
  final List<String> healthGoals;
  final List<String> medicalConditions;
  final List<String> allergies;

  const UserProfile({
    required this.userId,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.healthGoals,
    required this.medicalConditions,
    required this.allergies,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      activityLevel: json['activity_level'] as String,
      healthGoals: List<String>.from(json['health_goals'] as List),
      medicalConditions: List<String>.from(json['medical_conditions'] as List),
      allergies: List<String>.from(json['allergies'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'activity_level': activityLevel,
      'health_goals': healthGoals,
      'medical_conditions': medicalConditions,
      'allergies': allergies,
    };
  }

  double get bmi => weight / ((height / 100) * (height / 100));

  String get bmiCategory {
    if (bmi < 18.5) return '저체중';
    if (bmi < 25) return '정상';
    if (bmi < 30) return '과체중';
    return '비만';
  }

  UserProfile copyWith({
    String? userId,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? activityLevel,
    List<String>? healthGoals,
    List<String>? medicalConditions,
    List<String>? allergies,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      activityLevel: activityLevel ?? this.activityLevel,
      healthGoals: healthGoals ?? this.healthGoals,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      allergies: allergies ?? this.allergies,
    );
  }
}

