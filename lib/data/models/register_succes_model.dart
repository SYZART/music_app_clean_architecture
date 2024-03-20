import 'package:openmusic/domain/entities/register_succes_entiti.dart';

class RegisterSuccesModel extends RegisterSuccessEntity {
  const RegisterSuccesModel({
    required super.status,
    required super.data,
  });
  factory RegisterSuccesModel.fromJson(Map<String, dynamic> json) {
    return RegisterSuccesModel(
        status: json['status'],
        data: DataRegisterSuccesModel.fromJson(json['data']));
  }
  Map<String, dynamic> toJson() => {'status': status, 'data': data.toJson()};
  RegisterSuccessEntity toEntity() =>
      RegisterSuccessEntity(status: status, data: data.toEntity());
}

class DataRegisterSuccesModel extends DataRegisterSuccesEntitiy {
  const DataRegisterSuccesModel({required super.userId});

  factory DataRegisterSuccesModel.fromJson(Map<String, dynamic> json) {
    return DataRegisterSuccesModel(userId: json['userId']);
  }
}
