part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final UserModel user;
  const LoggedIn({required this.user, required this.token});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {}
