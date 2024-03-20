import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository authRepository;

  Login(this.authRepository);

  Future<Either<Failure, LoginEntity>> execute(
    String username,
    String password,
  ) {
    return authRepository.postLogin(username, password);
  }
}
