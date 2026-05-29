import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class VerifyEmailOtpUseCase {
  final AuthRepository _repository;
  VerifyEmailOtpUseCase(this._repository);

  Future<Either<Failure, void>> call(String email, String otp) =>
      _repository.verifyEmailOtp(email, otp);
}
