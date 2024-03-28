import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openmusic/data/models/login_model.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/entities/register_succes_entiti.dart';
import 'package:openmusic/domain/usecases/auth/clear_user_token.dart';
import 'package:openmusic/domain/usecases/auth/get_access_token.dart';
import 'package:openmusic/domain/usecases/auth/get_refresh_token.dart';
import 'package:openmusic/domain/usecases/auth/login.dart';
import 'package:openmusic/domain/usecases/auth/logout.dart';
import 'package:openmusic/domain/usecases/auth/register.dart';
import 'package:openmusic/domain/usecases/auth/save_user_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final Login login;
  final Logout logout;
// DB
  final GetAccessToken getAccessToken;
  final GetRefreshToken getRefreshToken;
  final SaveUserToken saveUserToken;
  final ClearUserToken clearUserToken;

  AuthBloc(
    this.register,
    this.login,
    this.getAccessToken,
    this.logout,
    this.saveUserToken,
    this.clearUserToken,
    this.getRefreshToken,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<OnRegisterEvent>((event, emit) async {
      emit(AuthRegisterLoading());

      final result = await register.execute(
          event.username, event.password, event.fullname);
      result.fold(
        (l) => emit(AuthRegisterFailed(l.message)),
        (r) => emit(AuthRegisterSuccess(r)),
      );
    });
    on<OnLoginEvent>((event, emit) async {
      emit(AuthLoginLoading());
      final result = await login.execute(event.username, event.password);

      result.fold(
        (l) => emit(AuthLoginFailed(l.message)),
        (r) => emit(AuthLoginSuccess(r)),
      );
    });

    on<OnGetToken>((event, emit) async {
      emit(const GetTokenLoading());

      final result = await getAccessToken.execute();
      await Future.delayed(const Duration(seconds: 2));
      result.fold(
          (l) => emit(const GetTokenFailed()),
          (r) => r == null
              ? emit(const GetTokenFailed())
              : emit(const GetTokenSucces()));
    });

    on<OnLogout>((event, emit) async {
      emit(const LogoutLoading());

      String refToken = '';

      final refreshToken = await getRefreshToken.execute();

      if (refreshToken.isRight()) {
        refToken = refreshToken.getOrElse(() => '')!;
      }

      final result = await logout.execute(refToken);

      await clearUserToken.execute();

      result.fold(
        (l) => emit(LogoutFailed(message: l.message)),
        (r) => emit(const LogoutSucces()),
      );
    });

    on<OnSaveUserToken>(((event, emit) async {
      emit(const SaveTokenLoading());
      final saveToken = await saveUserToken.execute(event.dataLoginModel);
      saveToken.fold((l) => emit(SaveTokenFailed(l.message)),
          (r) => emit(SaveTokenSucces(r)));
    }));
  }
}
