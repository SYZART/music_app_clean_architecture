import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String status;
  final String message;
  final DataLoginEntitiy data;
  const LoginEntity(
      {required this.status, required this.message, required this.data});

  @override
  List<Object?> get props => [status];
}

class DataLoginEntitiy extends Equatable {
  final String accessToken;
  final String refreshToken;
  const DataLoginEntitiy(
      {required this.accessToken, required this.refreshToken});
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  DataLoginEntitiy toEntity() =>
      DataLoginEntitiy(accessToken: accessToken, refreshToken: refreshToken);
  @override
  List<Object?> get props => [accessToken, refreshToken];
}
