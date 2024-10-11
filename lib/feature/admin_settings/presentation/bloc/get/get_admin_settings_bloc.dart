import 'dart:async';

import 'package:balibo_station/feature/admin_settings/model/admin_settings.dart';
import 'package:balibo_station/feature/admin_settings/service/admin_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_admin_settings_event.dart';
part 'get_admin_settings_state.dart';

class GetAdminSettingsBloc
    extends Bloc<GetAdminSettingsEvent, GetAdminSettingsState> {
  GetAdminSettingsBloc(this._adminSettingsService)
      : super(GetAdminSettingsInitial()) {
    _adminSettingsSubscription =
        _adminSettingsService.getAdminSettings().listen((settings) {
      add(_GetAdminSettingsSuccess(settings: settings));
    }, onError: (error) {
      add(_GetAdminSettingsError(message: error.toString()));
    });

    on<_GetAdminSettingsSuccess>(_success);
    on<_GetAdminSettingsError>(_error);
  }

  final AdminSettingsService _adminSettingsService;
  StreamSubscription<AdminSettingsModel?>? _adminSettingsSubscription;

  Future<void> _success(
    _GetAdminSettingsSuccess event,
    Emitter<GetAdminSettingsState> emit,
  ) async {
    if (event.settings != null) {
      emit(GetAdminSettingsSuccess(settings: event.settings!));
    } else {
      emit(GetAdminSettingsFailure(message: 'Admin settings not found'));
    }
  }

  Future<void> _error(
    _GetAdminSettingsError event,
    Emitter<GetAdminSettingsState> emit,
  ) async {
    emit(GetAdminSettingsFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _adminSettingsSubscription?.cancel();
    return super.close();
  }
}
