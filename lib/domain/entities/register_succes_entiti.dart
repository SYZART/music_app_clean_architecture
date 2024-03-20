import 'package:equatable/equatable.dart';

class RegisterSuccessEntity extends Equatable {
  final String status;
  final DataRegisterSuccesEntitiy data;
  const RegisterSuccessEntity({required this.status, required this.data});

  @override
  List<Object?> get props => [status];
}

class DataRegisterSuccesEntitiy extends Equatable {
  final String userId;
  const DataRegisterSuccesEntitiy({required this.userId});
  Map<String, dynamic> toJson() => {
        'userId': userId,
      };

  DataRegisterSuccesEntitiy toEntity() =>
      DataRegisterSuccesEntitiy(userId: userId);
  @override
  List<Object?> get props => [userId];
}
