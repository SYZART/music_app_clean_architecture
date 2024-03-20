import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/data/datasources/db/database_helper.dart';
import 'package:openmusic/presentation/bloc/songs%20bloc/songs_bloc.dart';

import '../../common/widgets/custom_snackbar.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  final tkn = await DatabaseHelper().logout();
                  log(tkn.toString());
                },
                child: const Text('Get Token')),
            TextButton(
                onPressed: () async {
                  final tkn = await DatabaseHelper().getAccessToken();
                  log(tkn.toString());
                },
                child: const Text('Get Token')),
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
                    child: Text('Tidak ada survei'),
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
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
