import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';
import 'package:openmusic/domain/usecases/song/get_all_song.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final GetAllSongUsecase getAllSong;

  SongsBloc(this.getAllSong) : super(SongsEmpty()) {
    on<OnGetSongs>((event, emit) async {
      emit(SongsLoading());

      final result = await getAllSong.execute();

      result.fold((fail) {
        emit(SongsError(fail.message));
      }, (succes) {
        succes.data.songs.isEmpty
            ? emit(SongsEmpty())
            : emit(SongsLoaded(succes));
      });
    });
  }
}
