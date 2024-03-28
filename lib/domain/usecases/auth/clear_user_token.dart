import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class ClearUserToken {
  final AuthRepository authRepository;
  ClearUserToken(this.authRepository);

  Future<Either<Failure, int>> execute() {
    return authRepository.clearUserToken();
  }
}
