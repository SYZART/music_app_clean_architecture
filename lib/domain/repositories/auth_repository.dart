import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/data/models/login_model.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/entities/register_succes_entiti.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterSuccessEntity>> postRegister(
      String username, String password, String fullname);
  Future<Either<Failure, LoginEntity>> postLogin(
    String username,
    String password,
  );
  Future<Either<Failure, bool>> setAccesToken(String accesToken);
  Future<String?> getAccesToken();
  Future<Either<Failure, bool>> logout();
}
