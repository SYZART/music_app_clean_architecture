part of 'songs_bloc.dart';

sealed class SongsState extends Equatable {
  const SongsState();

  @override
  List<Object> get props => [];
}

final class SongsEmpty extends SongsState {}

final class SongsLoading extends SongsState {}

final class SongsLoaded extends SongsState {
  final SongEntity songsModel;
  const SongsLoaded(this.songsModel);
}

final class SongsError extends SongsState {
  final String message;
  const SongsError(this.message);
}

final class SongsDioEmpty extends SongsState {}

final class SongsDioLoading extends SongsState {}

final class SongsDioLoaded extends SongsState {
  final SongEntity songsModel;
  const SongsDioLoaded(this.songsModel);
}

final class SongsDioError extends SongsState {
  final String message;
  const SongsDioError(this.message);
}
