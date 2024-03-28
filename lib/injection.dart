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
import 'package:openmusic/domain/usecases/auth/clear_user_token.dart';
import 'package:openmusic/domain/usecases/auth/get_access_token.dart';
import 'package:openmusic/domain/usecases/song/get_all_song.dart';
import 'package:openmusic/domain/usecases/auth/get_refresh_token.dart';
import 'package:openmusic/domain/usecases/auth/login.dart';
import 'package:openmusic/domain/usecases/auth/logout.dart';
import 'package:openmusic/domain/usecases/auth/register.dart';
import 'package:openmusic/domain/usecases/auth/save_user_token.dart';
import 'package:openmusic/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:openmusic/presentation/cubit/page_cubit.dart';
import 'package:openmusic/presentation/bloc/songs_bloc/songs_bloc.dart';

import 'data/datasources/db/sql_database_helper.dart';

final locator = GetIt.instance;

void init() {
  //Bloc
  locator.registerFactory(() => SongsBloc(locator()));
  locator.registerFactory(() => AuthBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  //Cubit
  locator.registerFactory(() => PageCubit());

  // usecase
  locator.registerLazySingleton(() => GetAllSong(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  locator.registerLazySingleton(() => GetAccessToken(locator()));
  locator.registerLazySingleton(() => SaveUserToken(locator()));
  locator.registerLazySingleton(() => ClearUserToken(locator()));
  locator.registerLazySingleton(() => GetRefreshToken(locator()));

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
      () => AuthLocalDataSourceImpl(sqlDatabaseHelper: locator()));

  // external
  locator.registerLazySingleton<SQLDatabaseHelper>(
      () => SQLDatabaseHelper()); // SQFlite

  locator.registerLazySingleton(() => DioClient(Dio()));
}
