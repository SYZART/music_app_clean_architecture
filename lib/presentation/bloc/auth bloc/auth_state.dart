part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// REGISTER

final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterSuccess extends AuthState {
  final RegisterSuccessEntity data;
  const AuthRegisterSuccess(this.data);
}

final class AuthRegisterFailed extends AuthState {
  final String message;
  const AuthRegisterFailed(this.message);
}

// LOGIN
final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final LoginEntity data;
  const AuthLoginSuccess(this.data);
}

final class AuthLoginFailed extends AuthState {
  final String message;
  const AuthLoginFailed(this.message);
}

// TOKEN
final class GetTokenLoading extends AuthState {
  const GetTokenLoading();
}

final class GetTokenSucces extends AuthState {
  const GetTokenSucces();
}

final class GetTokenFailed extends AuthState {
  const GetTokenFailed();
}
