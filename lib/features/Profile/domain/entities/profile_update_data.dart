class ProfileUpdateData {
  final String name;
  final String? phone;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? bloodGroup;
  final List<String> allergies;
  final List<String> chronicConditions;
  final bool isDiabetic;

  const ProfileUpdateData({
    required this.name,
    this.phone,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodGroup,
    this.allergies = const [],
    this.chronicConditions = const [],
    this.isDiabetic = false,
  });

  Map<String, dynamic> toJson() {
    final profileMap = <String, dynamic>{};
    if (age != null && age! > 0) profileMap['age'] = age;
    if (gender != null && gender!.isNotEmpty) {
      profileMap['gender'] = gender!.toLowerCase();
    }
    if (height != null && height! > 0) profileMap['height'] = height;
    if (weight != null && weight! > 0) profileMap['weight'] = weight;
    if (bloodGroup != null &&
        bloodGroup!.isNotEmpty &&
        bloodGroup != 'Select') {
      profileMap['bloodGroup'] = bloodGroup;
    }
    profileMap['allergies'] = allergies;
    profileMap['chronicConditions'] = chronicConditions;
    profileMap['isDiabetic'] = isDiabetic ? 'yes' : 'no';

    return {
      'name': name,
      if (phone != null && phone!.isNotEmpty) 'phone': phone,
      'profile': profileMap,
    };
  }
}
