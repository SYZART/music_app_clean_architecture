import 'package:dartz/dartz.dart';
import 'package:openmusic/common/failure.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';
import 'package:openmusic/domain/repositories/song_repository.dart';

class GetAllSong {
  final SongRepository repository;

  GetAllSong(this.repository);

  Future<Either<Failure, SongsModel>> execute() {
    return repository.getAllSong();
  }
}
