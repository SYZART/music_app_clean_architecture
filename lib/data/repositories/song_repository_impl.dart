import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/common/network/error_handler.dart';
import 'package:openmusic/data/datasources/remote/song_remote_data_source.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';
import 'package:openmusic/domain/repositories/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource songRemoteDataSource;
  SongRepositoryImpl({required this.songRemoteDataSource});

  @override
  Future<Either<Failure, SongsModel>> getAllSong() async {
    try {
      final result = await songRemoteDataSource.getAllSong();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  @override
  Future<Either<Failure, SongsModel>> getAllSongDio() async {
    try {
      final result = await songRemoteDataSource.getAllSongDio();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }

  // SongRepositoryImpl({
  //   // required this.remoteDataSource,
  //   // required this.localDataSource,
  // });

  // @override
  // Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
  //   try {
  //     final result = await remoteDataSource.getNowPlayingMovies();
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }
}
