import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/presentation/bloc/songs_bloc/songs_bloc.dart';

import '../../common/widgets/custom_snackbar.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<SongsBloc, SongsState>(
          listener: (context, state) {
            if (state is SongsError) {
              CustomSnackbar.showMessage(state.message, context);
            }
          },
          builder: (context, state) {
            if (state is SongsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SongsEmpty) {
              return const Center(
                child: Text('Tidak ada lagu'),
              );
            }
            if (state is SongsLoaded) {
              return Column(
                children: state.songsModel.data.songs
                    .map(
                      (e) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [Text(e.title), Text(e.performer)],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<SongsBloc>().add(OnGetSongs());
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
