import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/register_succes_entiti.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository authRepository;

  Register(this.authRepository);

  Future<Either<Failure, RegisterSuccessEntity>> execute(
      String username, String password, String fullname) {
    return authRepository.postRegister(username, password, fullname);
  }
}
