import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;
  RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) =>
      _repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
}
