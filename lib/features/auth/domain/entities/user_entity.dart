import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String token;
  final String? profileImageUrl;
  final String? phoneNumber;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
    this.profileImageUrl,
    this.phoneNumber,
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        token,
        profileImageUrl,
        phoneNumber,
      ];
}
