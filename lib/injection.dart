import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:openmusic/common/network/api.dart';
import 'package:openmusic/data/datasources/local/auth_local_data_source.dart';
import 'package:openmusic/data/datasources/remote/auth_remote_data_source.dart';
import 'package:openmusic/data/datasources/remote/song_remote_data_source.dart';
import 'package:openmusic/data/repositories/auth_repository_impl.dart';
import 'package:openmusic/data/repositories/song_repository_impl.dart';
import 'package:openmusic/domain/repositories/auth_repository.dart';
import 'package:openmusic/domain/repositories/song_repository.dart';
import 'package:openmusic/domain/usecases/get_access_token.dart';
import 'package:openmusic/domain/usecases/get_all_song.dart';
import 'package:openmusic/domain/usecases/login.dart';
import 'package:openmusic/domain/usecases/register.dart';
import 'package:openmusic/presentation/bloc/auth%20bloc/auth_bloc.dart';
import 'package:openmusic/presentation/bloc/songs%20bloc/songs_bloc.dart';

import 'data/datasources/db/database_helper.dart';

final locator = GetIt.instance;

void init() {
  //Bloc
  locator.registerFactory(() => SongsBloc(locator()));
  locator.registerFactory(() => AuthBloc(locator(), locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetAllSong(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => GetAccessToken(locator()));

  // repository
  locator.registerLazySingleton<SongRepository>(
    () => SongRepositoryImpl(songRemoteDataSource: locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        authRemoteDataSource: locator(), authLocalDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl(dioClient: locator()));
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioClient: locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(databaseHelper: locator()));

  // external

  locator.registerLazySingleton<DatabaseHelper>(
      () => DatabaseHelper()); // Shared Preferences

  locator.registerLazySingleton(() => DioClient(Dio()));
}
