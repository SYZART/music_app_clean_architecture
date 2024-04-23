import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:openmusic/common/constants.dart';
import 'package:openmusic/common/exception.dart';
import 'package:openmusic/data/datasources/remote/song_remote_data_source.dart';
import 'package:openmusic/data/models/song_model.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';

import '../../helpers/constant/dummy_data_json.dart';
import '../../helpers/helper_test.mocks.dart';
import '../../helpers/json_reader.dart';

void main() {
  late MockSongRemoteDataSource songRemoteDataSource;
  late MockDioClient mockDioClient;
  late SongRemoteDataSourceImpl songRemoteDataSourceImpl;

  setUp(() {
    songRemoteDataSource = MockSongRemoteDataSource();
    mockDioClient = MockDioClient();
    // // mockSharedPreferences = MockSharedPreferences();
    songRemoteDataSourceImpl =
        SongRemoteDataSourceImpl(dioClient: mockDioClient);
  });
  group("Song Remote DataSource", () {
    RequestOptions requestOptions = RequestOptions();
    test('should return [SongsModel] when the response code is 200', () async {
      //arange
      SongModel songsModel = SongModel(
          status: "status",
          data: DataSongsModel(songs: [
            SongsEntity(id: 'id', title: 'title', performer: 'performer')
          ]));
      //stub
      when(songRemoteDataSource.getAllSong())
          .thenAnswer((_) async => songsModel);
      //act
      var result = await songRemoteDataSource.getAllSong();

      expect(result, isA<SongModel>());
    });

    test('should return list of Movie Model when the response code is 200',
        () async {
      //arange

      final responseData = json.decode(readJson(DummyData.songSuccesJson));
      final data =
          SongModel.fromJson(json.decode(readJson(DummyData.songSuccesJson)));

      //stub
      when(mockDioClient.get('/songs',
              queryParameters: null,
              options: null,
              cancelToken: null,
              onReceiveProgress: null))
          .thenAnswer((realInvocation) async => Response(
              requestOptions: requestOptions,
              statusCode: 200,
              data: responseData));
      //act
      final result = await songRemoteDataSourceImpl.getAllSong();

      expect(result, equals(data));
    });
  });
}
