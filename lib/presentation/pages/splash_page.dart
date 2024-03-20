import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/presentation/bloc/auth%20bloc/auth_bloc.dart';
import 'package:openmusic/presentation/pages/login_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.microtask(() => context.read<AuthBloc>().add(const OnGetToken()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GetTokenFailed) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          }
          if (state is GetTokenSucces) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SongPage(),
                ));
          }
        },
        child: const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            )),
      ),
    );
  }
}
