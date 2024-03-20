import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/common/constants.dart';
import 'package:openmusic/injection.dart' as di;
import 'package:openmusic/presentation/bloc/auth%20bloc/auth_bloc.dart';
import 'package:openmusic/presentation/bloc/songs%20bloc/songs_bloc.dart';
import 'package:openmusic/presentation/pages/login_page.dart';
import 'package:openmusic/presentation/pages/splash_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SongsBloc>()..add(OnGetSongs()),
        ),
        BlocProvider(create: (_) => di.locator<AuthBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            elevatedButtonTheme: elevatedButtonTheme,
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.teal,
                onPrimary: Colors.black,
                secondary: Colors.teal.shade900,
                onSecondary: Colors.tealAccent,
                error: Colors.redAccent,
                onError: Colors.red,
                background: Colors.white,
                onBackground: Colors.white10,
                surface: Colors.white,
                onSurface: Colors.blueGrey)),
        home: const SplashPage(),
      ),
    );
  }
}
