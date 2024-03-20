import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class GetAccessToken {
  final AuthRepository authRepository;

  GetAccessToken(this.authRepository);

  Future<String?> execute() {
    return authRepository.getAccesToken();
  }
}
