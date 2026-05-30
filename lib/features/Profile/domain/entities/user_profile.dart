class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profilePicture;

  // profile sub-object
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? bloodGroup;
  final List<String> allergies;
  final List<String> chronicConditions;
  final bool isDiabetic;
  final String? activityLevel;
  final String? dietaryPreference;

  // healthMetrics
  final double? bmi;
  final int healthScore;

  // nutritionGoal
  final String? nutritionGoalType;
  final double? targetWeight;
  final int? calorieGoal;
  final int? proteinGoal;
  final int? carbsGoal;
  final int? fatGoal;

  // fitnessProfile
  final String? primaryGoal;
  final String? timeframe;

  // account
  final int streakDays;
  final String? subscriptionPlan;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodGroup,
    this.allergies = const [],
    this.chronicConditions = const [],
    this.isDiabetic = false,
    this.activityLevel,
    this.dietaryPreference,
    this.bmi,
    this.healthScore = 0,
    this.nutritionGoalType,
    this.targetWeight,
    this.calorieGoal,
    this.proteinGoal,
    this.carbsGoal,
    this.fatGoal,
    this.primaryGoal,
    this.timeframe,
    this.streakDays = 0,
    this.subscriptionPlan,
  });

  String get avatarLetter =>
      name.isNotEmpty ? name[0].toUpperCase() : 'U';

  String get displayBmi =>
      bmi != null && bmi! > 0 ? bmi!.toStringAsFixed(1) : '—';

  String get ageLabel => age != null && age! > 0 ? '$age yrs' : 'Age not set';

  String get genderLabel {
    if (gender == null || gender!.isEmpty) return 'Other';
    return '${gender![0].toUpperCase()}${gender!.substring(1)}';
  }

  String get heightLabel =>
      height != null && height! > 0 ? '${height!.toStringAsFixed(0)} cm' : 'Height not set';
}
