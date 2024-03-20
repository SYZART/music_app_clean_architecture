import 'package:openmusic/domain/entities/login_entiti.dart';

class LoginModel extends LoginEntity {
  const LoginModel(
      {required super.status, required super.message, required super.data});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        status: json['status'],
        message: json['message'],
        data: DataLoginModel.fromJson(json['data']));
  }
  Map<String, dynamic> toJson() => {'status': status, 'data': data.toJson()};
  LoginEntity toEntity() =>
      LoginEntity(status: status, message: message, data: data.toEntity());
}

class DataLoginModel extends DataLoginEntitiy {
  const DataLoginModel(
      {required super.accessToken, required super.refreshToken});
  factory DataLoginModel.fromJson(Map<String, dynamic> json) {
    return DataLoginModel(
        accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}
