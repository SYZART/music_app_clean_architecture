// To parse this JSON data, do
//
//     final songsModel = songsModelFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

SongsModel songsModelFromJson(String str) =>
    SongsModel.fromJson(json.decode(str));

String songsModelToJson(SongsModel data) => json.encode(data.toJson());

class SongsModel extends Equatable {
  String status;
  Data data;

  SongsModel({
    required this.status,
    required this.data,
  });

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };

  @override
  List<Object?> get props => [status, data];
}

class Data {
  List<Song> songs;

  Data({
    required this.songs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
      };
}

class Song {
  String id;
  String title;
  String performer;

  Song({
    required this.id,
    required this.title,
    required this.performer,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        title: json["title"],
        performer: json["performer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "performer": performer,
      };
}
