import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;
  ResetPasswordUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String otp,
    required String newPassword,
  }) =>
      _repository.resetPassword(email: email, otp: otp, newPassword: newPassword);
}
