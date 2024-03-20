import 'dart:developer';

import 'package:openmusic/common/network/api.dart';
import 'package:openmusic/data/models/login_model.dart';

import '../../../common/exception.dart';
import '../../models/register_succes_model.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterSuccesModel> postRegister(
      String username, String password, String fullname);
  Future<LoginModel> postLogin(
    String username,
    String password,
  );
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<RegisterSuccesModel> postRegister(
      String username, String password, String fullname) async {
    final response = await dioClient.post('/users', data: {
      'username': username,
      'password': password,
      'fullname': fullname
    });

    if (response.statusCode == 201) {
      return RegisterSuccesModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LoginModel> postLogin(
    String username,
    String password,
  ) async {
    final response = await dioClient.post('/authentications', data: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 201) {
      return LoginModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
