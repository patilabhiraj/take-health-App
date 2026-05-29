import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class ResendEmailOtpUseCase {
  final AuthRepository _repository;
  ResendEmailOtpUseCase(this._repository);

  Future<Either<Failure, void>> call(String email) =>
      _repository.resendEmailOtp(email);
}
