import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/data/models/login_model.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

class SaveUserToken {
  final AuthRepository authRepository;

  SaveUserToken(this.authRepository);

  Future<Either<Failure, String>> execute(DataLoginModel loginModel) {
    return authRepository.saveUserToken(loginModel);
  }
}
