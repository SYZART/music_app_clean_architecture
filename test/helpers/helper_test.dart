import 'package:dio/dio.dart';
import 'package:openmusic/common/network/api.dart';
import 'package:openmusic/data/datasources/db/sql_database_helper.dart';
import 'package:openmusic/data/datasources/remote/song_remote_data_source.dart';
import 'package:openmusic/domain/repositories/song_repository.dart';
import 'package:openmusic/domain/usecases/song/get_all_song.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    SongRepository,
    SongRemoteDataSource,
    GetAllSongUsecase,
    Dio,
    SQLDatabaseHelper,
  ],
  customMocks: [MockSpec<DioClient>(as: #MockDioClient)],
)
void main() {}
