import 'dart:async';

import 'package:balibo_station/feature/login/model/login.dart';
import 'package:balibo_station/feature/login/model/user.dart';
import 'package:balibo_station/feature/login/service/login.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService;
  StreamSubscription<UserModel?>? _userSubscription;

  LoginBloc(this._loginService) : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
    on<_LoginFailureEvent>((event, emit) {
      emit(LoginFailure(message: event.message));
    });

    on<_LoginSuccessEvent>((event, emit) {
      emit(LoginSuccess(user: event.user));
    });
  }

  Future<void> _onLoginUser(
    LoginUser event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      await _userSubscription?.cancel();

      _userSubscription =
          _loginService.loginAndListenToUser(event.loginModel).listen((user) {
        if (user == null) {
          add(_LoginFailureEvent(message: 'Login zamanı xəta'));
        } else {
          add(_LoginSuccessEvent(user: user));
        }
      }, onError: (error) {
        add(_LoginFailureEvent(message: error.toString()));
      });
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<LoginState> emit,
  ) async {
    emit(LogoutSuccess());
    _userSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
