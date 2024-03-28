import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  Future<Either<Failure, bool>> execute(String refreshToken) {
    return authRepository.logout(refreshToken);
  }
}
