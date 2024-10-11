part of 'get_admin_settings_bloc.dart';

@immutable
abstract class GetAdminSettingsEvent {}

class _GetAdminSettingsSuccess extends GetAdminSettingsEvent {
  final AdminSettingsModel? settings;

  _GetAdminSettingsSuccess({required this.settings});
}

class _GetAdminSettingsError extends GetAdminSettingsEvent {
  final String message;

  _GetAdminSettingsError({required this.message});
}
