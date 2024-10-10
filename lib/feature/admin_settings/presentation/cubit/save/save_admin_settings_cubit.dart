import 'package:balibo_station/feature/admin_settings/model/admin_settings.dart';
import 'package:balibo_station/feature/admin_settings/service/admin_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'save_admin_settings_state.dart';

class SaveAdminSettingsCubit extends Cubit<SaveAdminSettingsState> {
  SaveAdminSettingsCubit(this._adminSettingsService)
      : super(SaveAdminSettingsInitial());
  final AdminSettingsService _adminSettingsService;

  Future<void> save(AdminSettingsModel adminSettingsModel) async {
    try {
      emit(SaveAdminSettingsLoading());
      await _adminSettingsService.save(adminSettingsModel);
      emit(SaveAdminSettingsSuccess());
    } catch (e) {
      emit(SaveAdminSettingsError(message: e.toString()));
    }
  }
}
