import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.profilePicture,
    super.age,
    super.gender,
    super.height,
    super.weight,
    super.bloodGroup,
    super.allergies,
    super.chronicConditions,
    super.isDiabetic,
    super.activityLevel,
    super.dietaryPreference,
    super.bmi,
    super.healthScore,
    super.nutritionGoalType,
    super.targetWeight,
    super.calorieGoal,
    super.proteinGoal,
    super.carbsGoal,
    super.fatGoal,
    super.primaryGoal,
    super.timeframe,
    super.streakDays,
    super.subscriptionPlan,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>? ?? {};
    final metrics = json['healthMetrics'] as Map<String, dynamic>? ?? {};
    final goal = json['nutritionGoal'] as Map<String, dynamic>? ?? {};
    final fitness = profile['fitnessProfile'] as Map<String, dynamic>? ?? {};
    final sub = json['subscription'] as Map<String, dynamic>? ?? {};

    return UserProfileModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      profilePicture: json['profilePicture'] as String?,
      age: profile['age'] as int?,
      gender: profile['gender'] as String?,
      height: (profile['height'] as num?)?.toDouble(),
      weight: (profile['weight'] as num?)?.toDouble(),
      bloodGroup: profile['bloodGroup'] as String?,
      allergies: _toList(profile['allergies']),
      chronicConditions: _toList(profile['chronicConditions']),
      isDiabetic: profile['isDiabetic'] == 'yes' ||
          profile['isDiabetic'] == true,
      activityLevel: profile['activityLevel'] as String?,
      dietaryPreference: profile['dietaryPreference'] as String?,
      bmi: (metrics['bmi'] as num?)?.toDouble(),
      healthScore: metrics['healthScore'] as int? ?? 0,
      nutritionGoalType: goal['goal'] as String?,
      targetWeight: (goal['targetWeight'] as num?)?.toDouble(),
      calorieGoal: goal['calorieGoal'] as int?,
      proteinGoal: goal['proteinGoal'] as int?,
      carbsGoal: goal['carbsGoal'] as int?,
      fatGoal: goal['fatGoal'] as int?,
      primaryGoal: fitness['primaryGoal'] as String?,
      timeframe: fitness['timeframe'] as String?,
      streakDays: json['streakDays'] as int? ?? 0,
      subscriptionPlan: sub['plan'] as String?,
    );
  }

  static List<String> _toList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty && s != 'string')
          .toList();
    }
    return [];
  }
}
