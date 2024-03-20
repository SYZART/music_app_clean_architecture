import 'dart:convert';
import 'dart:developer';
import 'package:openmusic/common/exception.dart';
import 'package:openmusic/common/network/api.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';

abstract class SongRemoteDataSource {
  Future<SongsModel> getAllSong();
  Future<SongsModel> getAllSongDio();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  // static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseURL = 'http://10.0.2.2:5000';

  // final http.Client client;
  final DioClient dioClient;

  SongRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<SongsModel> getAllSong() async {
    final response = await dioClient.get('/songs');

    if (response.statusCode == 200) {
      return SongsModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SongsModel> getAllSongDio() async {
    final response = await dioClient.get('/songs');

    if (response.statusCode == 200) {
      return SongsModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
