import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class GetRefreshToken {
  final AuthRepository authRepository;

  GetRefreshToken(this.authRepository);

  Future<Either<Failure, String?>> execute() {
    return authRepository.getUserToken('refreshToken');
  }
}
