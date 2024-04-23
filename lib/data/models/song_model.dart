// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:openmusic/domain/entities/song_entiti.dart';

SongModel songFromJson(String str) => SongModel.fromJson(jsonDecode(str));

class SongModel extends SongEntity {
  SongModel({
    required super.status,
    required super.data,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        status: json['status'],
        data: DataSongsModel.fromJson(json['data']),
      );
  SongModel toEntity() => SongModel(status: status, data: data.toEntity());
}

class DataSongsModel extends DataSongsEntitiy {
  DataSongsModel({
    required super.songs,
  });

  factory DataSongsModel.fromJson(Map<String, dynamic> json) => DataSongsModel(
        songs: List<SongsModel>.from(
            json["songs"].map((x) => SongsModel.fromJson(x))),
      );

  DataSongsModel toEntity() => DataSongsModel(songs: songs[0].toEntity());
}

class SongsModel extends SongsEntity {
  SongsModel({
    required super.id,
    required super.title,
    required super.performer,
  });

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
        id: json["id"],
        title: json["title"],
        performer: json["performer"],
      );
}
