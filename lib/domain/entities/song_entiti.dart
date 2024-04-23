// To parse this JSON data, do
//
//     final songsModel = songsModelFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  String status;
  DataSongsEntitiy data;

  SongEntity({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];
}

class DataSongsEntitiy extends Equatable {
  List<SongsEntity> songs;

  DataSongsEntitiy({
    required this.songs,
  });

  DataSongsEntitiy toEntity() => DataSongsEntitiy(songs: songs);
  @override
  List<Object?> get props => [songs];
}

class SongsEntity extends Equatable {
  String id;
  String title;
  String performer;

  SongsEntity({
    required this.id,
    required this.title,
    required this.performer,
  });

  List<SongsEntity> toEntity() =>
      [SongsEntity(id: id, title: title, performer: performer)];
  @override
  List<Object?> get props => [id, performer, title];
}
