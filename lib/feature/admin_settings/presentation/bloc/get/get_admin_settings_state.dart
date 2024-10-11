part of 'get_admin_settings_bloc.dart';

@immutable
abstract class GetAdminSettingsState {}

class GetAdminSettingsInitial extends GetAdminSettingsState {}

class GetAdminSettingsSuccess extends GetAdminSettingsState {
  final AdminSettingsModel settings;

  GetAdminSettingsSuccess({required this.settings});
}

class GetAdminSettingsFailure extends GetAdminSettingsState {
  final String message;

  GetAdminSettingsFailure({required this.message});
}
