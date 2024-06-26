import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';
import 'package:openmusic/domain/repositories/song_repository.dart';

class GetAllSongUsecase {
  final SongRepository repository;

  GetAllSongUsecase(this.repository);

  Future<Either<Failure, SongEntity>> execute() {
    return repository.getAllSong();
  }
}
