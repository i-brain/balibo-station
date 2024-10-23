part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}

class LogoutSuccess extends LoginState {}
