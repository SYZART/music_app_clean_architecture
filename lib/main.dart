import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/bloc_observer.dart';
import 'package:openmusic/common/routes.dart';
import 'package:openmusic/common/theme.dart';
import 'package:openmusic/injection.dart' as di;
import 'package:openmusic/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:openmusic/presentation/cubit/page_cubit.dart';
import 'package:openmusic/presentation/bloc/songs_bloc/songs_bloc.dart';
import 'package:openmusic/presentation/pages/splash_page.dart';

void main() {
  Logging.initialize(showLog: true);
  Bloc.observer = SimpleBlocObserver();
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
        BlocProvider(
          create: (_) => di.locator<AuthBloc>()
            ..add(
              const OnGetToken(),
            ),
        ),
        BlocProvider(
          create: (_) => di.locator<PageCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: theme,
        onGenerateRoute: Approutes.onGeneretaRoutes,
        home: const SplashPage(),
      ),
    );
  }
}
