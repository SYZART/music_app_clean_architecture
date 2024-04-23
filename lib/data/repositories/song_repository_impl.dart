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
  Future<Either<Failure, SongEntity>> getAllSong() async {
    try {
      final result = await songRemoteDataSource.getAllSong();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(ErrorHandler.handle(e).serverFailure);
    }
  }
}
