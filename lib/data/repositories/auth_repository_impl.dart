import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/data/datasources/remote/auth_remote_data_source.dart';
import 'package:openmusic/data/datasources/local/auth_local_data_source.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/entities/register_succes_entiti.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';

import '../../common/network/error_handler.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, RegisterSuccessEntity>> postRegister(
      String username, String password, String fullname) async {
    try {
      final result =
          await authRemoteDataSource.postRegister(username, password, fullname);
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> postLogin(
    String username,
    String password,
  ) async {
    try {
      final result = await authRemoteDataSource.postLogin(username, password);
      await authLocalDataSource.setAccesToken(result.data.accessToken);

      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<String?> getAccesToken() async {
    final result = await authLocalDataSource.getAccesToken();
    return result;
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await authLocalDataSource.logout();
      return Right(result);
    } catch (e) {
      return const Left(
          DatabaseFailure('Terjadi Kesalahan Penyimpanan Internal'));
    }
  }

  @override
  Future<Either<Failure, bool>> setAccesToken(String accesToken) async {
    try {
      final result = await authLocalDataSource.setAccesToken(accesToken);
      return Right(result);
    } catch (e) {
      return const Left(
          DatabaseFailure('Terjadi Kesalahan Penyimpanan Internal'));
    }
  }
}
