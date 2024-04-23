import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:openmusic/common/exception.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/data/datasources/remote/auth_remote_data_source.dart';
import 'package:openmusic/data/datasources/local/auth_local_data_source.dart';
import 'package:openmusic/data/models/login_model.dart';
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

      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<Either<Failure, bool>> logout(String refreshToken) async {
    try {
      final result = await authRemoteDataSource.logOut(refreshToken);

      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<Either<Failure, String>> putRefreshToken() async {
    try {
      final result = await authRemoteDataSource.postRefreshToken('');

      return Right(result.data.accessToken);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<Either<Failure, String>> saveUserToken(
      DataLoginModel loginModel) async {
    try {
      final result = await authLocalDataSource
          .saveUserToken(DataLoginModel.fromEntity(loginModel));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, int>> clearUserToken() async {
    try {
      final result = await authLocalDataSource.clearUserToken();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String?>> getUserToken(String tokenName) async {
    try {
      final result = await authLocalDataSource.getUserToken(tokenName);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
