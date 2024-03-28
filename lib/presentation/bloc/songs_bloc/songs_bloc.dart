import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openmusic/domain/entities/song_entiti.dart';
import 'package:openmusic/domain/usecases/song/get_all_song.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final GetAllSong getAllSong;
  SongsBloc(this.getAllSong) : super(SongsEmpty()) {
    // on<SongsEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<OnGetSongs>((event, emit) async {
      emit(SongsLoading());
      final result = await getAllSong.execute();
      result.fold((l) {
        emit(SongsError(l.message));
      }, (r) {
        r.data.songs.isEmpty ? emit(SongsEmpty()) : emit(SongsLoaded(r));
      });
    });
  }
}
