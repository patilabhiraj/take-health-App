import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository _repository;
  GoogleLoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(String token) =>
      _repository.googleLogin(token);
}
