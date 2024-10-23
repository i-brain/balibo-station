part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  final LoginModel loginModel;
  LoginUser({LoginModel? loginModel})
      : loginModel = (loginModel ?? LoginModel());
}

class LogoutUser extends LoginEvent {}

class _LoginFailureEvent extends LoginEvent {
  final String message;

  _LoginFailureEvent({required this.message});
}

class _LoginSuccessEvent extends LoginEvent {
  final UserModel user;

  _LoginSuccessEvent({required this.user});
}
