import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.token,
    super.profileImageUrl,
    super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] as Map<String, dynamic>?;
    final userJson = dataJson?['user'] ?? json['user'] ?? json;

    final extractedToken = json['token'] ??
        json['accessToken'] ??
        json['access_token'] ??
        dataJson?['token'] ??
        dataJson?['accessToken'] ??
        dataJson?['access_token'] ??
        userJson['token'] ??
        userJson['accessToken'] ??
        userJson['access_token'] ??
        '';

    final profileImageUrl = userJson['profileImageUrl'] ??
        userJson['profileImage'] ??
        userJson['photoUrl'] ??
        userJson['photo'] ??
        userJson['picture'] ??
        userJson['avatar'] ??
        userJson['image'];

    // Handle name field - backend may return single 'name' or separate firstName/lastName
    String firstName = '';
    String lastName = '';
    
    if (userJson['name'] != null) {
      // Split name into firstName and lastName
      final nameParts = (userJson['name'] as String).split(' ');
      firstName = nameParts.first;
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    } else {
      firstName = userJson['firstName'] ?? userJson['first_name'] ?? '';
      lastName = userJson['lastName'] ?? userJson['last_name'] ?? '';
    }

    return UserModel(
      id: (userJson['_id'] ?? userJson['id'] ?? '').toString(),
      email: userJson['email'] ?? '',
      firstName: firstName,
      lastName: lastName,
      token: extractedToken,
      profileImageUrl: profileImageUrl?.toString(),
      phoneNumber: userJson['phoneNumber'] ?? userJson['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'token': token,
        if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      };
}
