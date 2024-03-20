part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String fullname;
  const OnRegisterEvent(
      {required this.username, required this.fullname, required this.password});
}

class OnLoginEvent extends AuthEvent {
  final String username;
  final String password;
  const OnLoginEvent({required this.username, required this.password});
}

class OnGetToken extends AuthEvent {
  const OnGetToken();
}

class OnShowPassword extends AuthEvent {
  final bool status;
  const OnShowPassword({this.status = false});
}
