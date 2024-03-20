// To parse this JSON data, do
//
//     final res = resFromJson(jsonString);

import 'dart:convert';

Res resFromJson(String str) => Res.fromJson(json.decode(str));

String resToJson(Res data) => json.encode(data.toJson());

class Res {
  String status;
  Data data;

  Res({
    required this.status,
    required this.data,
  });

  factory Res.fromJson(Map<String, dynamic> json) => Res(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
