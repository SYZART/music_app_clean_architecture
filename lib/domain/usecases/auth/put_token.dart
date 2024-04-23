import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class PutAccessToken {
  final AuthRepository authRepository;

  PutAccessToken(this.authRepository);

  Future<Either<Failure, String>> execute() {
    return authRepository.putRefreshToken();
  }
}
