import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';

abstract class SongRepository {
  Future<Either<Failure, SongEntity>> getAllSong();
}
