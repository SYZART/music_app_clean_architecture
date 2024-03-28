import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/presentation/cubit/page_cubit.dart';
import 'package:openmusic/presentation/pages/profile_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const SongPage();
        case 1:
          return const ProfilePage();
        // case 2:
        //   return WalletPage();
        // case 3:
        //   return SettingPage();
        default:
          return const SongPage();
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Music App'),
        ),
        // body: BlocBuilder<PageBloc, PageState>(
        //   builder: (context, state) {
        //     if (state is PageInitial) {
        //       return buildContent(0);
        //     }
        //     if (state is PageUpdated) {
        //       return buildContent(state.currentPage);
        //     }
        //     return Container();
        //   },
        // ),
        body: BlocBuilder<PageCubit, int>(
          builder: (context, state) {
            return buildContent(state);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          currentIndex: context.watch<PageCubit>().state,
          onTap: (a) {
            context.read<PageCubit>().setPage(a);
            // context.read<PageBloc>().add(OnSwicthPage(currentPage: a));
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            )
          ],
        ));
  }
}
