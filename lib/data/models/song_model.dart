// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:openmusic/data/models/response_model.dart';
import 'dart:convert';

SongModel songFromJson(String str) => SongModel.fromJson(jsonDecode(str));

class SongModel extends Equatable implements Res {
  final String id;
  final String title;
  final String performer;

  @override
  Data data;

  @override
  String status;

  SongModel({
    required this.status,
    required this.data,
    required this.id,
    required this.title,
    required this.performer,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        status: json['status'],
        data: json["data"],
        id: json["id"],
        title: json["title"],
        performer: json["performer"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "performer": performer,
      };

  @override
  List<Object?> get props => [status, data, id, title, performer];
}
