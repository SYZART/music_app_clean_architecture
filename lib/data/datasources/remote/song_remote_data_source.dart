import 'dart:developer';

import 'package:openmusic/common/exception.dart';
import 'package:openmusic/common/network/api.dart';
import 'package:openmusic/data/models/song_model.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';

abstract class SongRemoteDataSource {
  Future<SongModel> getAllSong();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final DioClient dioClient;

  SongRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<SongModel> getAllSong() async {
    final response = await dioClient.get('/songs');
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return SongModel.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
