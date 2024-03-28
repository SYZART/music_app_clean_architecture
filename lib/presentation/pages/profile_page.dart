import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/common/widgets/custom_snackbar.dart';
import 'package:openmusic/common/widgets/loading.dart';
import 'package:openmusic/data/datasources/db/sql_database_helper.dart';
import 'package:openmusic/data/models/login_model.dart';
import 'package:openmusic/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:openmusic/presentation/cubit/page_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          LoadingScreen.instance().show(context: context);
        }
        if (state is LogoutFailed) {
          LoadingScreen.instance().hide();
          CustomSnackbar.showMessage(state.message, context);
        }
        if (state is LogoutSucces) {
          LoadingScreen.instance().hide();
          Navigator.pushReplacementNamed(context, '/login');
          // context.read<PageCubit>().setPage(0);
        }
      },
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const OnLogout());
                },
                child: const Text('Logout')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  final a = await SQLDatabaseHelper().getWatchlistMovies();
                  log(a.toString());
                },
                child: const Text('DB')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  final a = await SQLDatabaseHelper().insertUserToken(
                      const DataLoginModel(
                          accessToken: 'a', refreshToken: 'c'));
                  log(a.toString());
                },
                child: const Text('save')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  final a = await SQLDatabaseHelper().clearUserTable();
                  log(a.toString());
                },
                child: const Text('clear')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  final a =
                      await SQLDatabaseHelper().readUserToken('accessToken');
                  final av =
                      await SQLDatabaseHelper().readUserToken('refreshToken');
                  log(a ?? '');
                  log(av ?? '');
                },
                child: const Text('acc')),
          ),

          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.pushNamedAndRemoveUntil(
          //           context, '/login', (route) => false);
          //     },
          //     child: Text('out')),
          // ElevatedButton(
          //     onPressed: () async {
          //       final tkn = await DatabaseHelper().getAccessToken();
          //       final tknr = await DatabaseHelper().getRefreshToken();
          //       log(tkn.toString());
          //       log(tknr.toString());
          //     },
          //     child: Text('get'))
        ],
      ),
    );
  }
}
