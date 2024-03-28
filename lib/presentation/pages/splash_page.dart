import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/common/theme.dart';
import 'package:openmusic/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:openmusic/presentation/pages/login_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GetTokenFailed) {
            Navigator.pushReplacementNamed(context, '/login');
          }
          if (state is GetTokenSucces) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Image.asset(
                'assets/images/musium_logo.png',
                width: 200,
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
