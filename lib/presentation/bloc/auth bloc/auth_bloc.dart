import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:openmusic/domain/entities/login_entiti.dart';
import 'package:openmusic/domain/entities/register_succes_entiti.dart';
import 'package:openmusic/domain/usecases/get_access_token.dart';
import 'package:openmusic/domain/usecases/login.dart';
import 'package:openmusic/domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final Login login;
  final GetAccessToken getAccessToken;
  AuthBloc(this.register, this.login, this.getAccessToken)
      : super(AuthInitial()) {
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
    on<OnShowPassword>((event, emit) => emit);
    on<OnGetToken>((event, emit) async {
      emit(const GetTokenLoading());

      final result = await getAccessToken.execute();
      await Future.delayed(const Duration(seconds: 2));
      result != null
          ? emit(const GetTokenSucces())
          : emit(const GetTokenFailed());
    });
  }
}
