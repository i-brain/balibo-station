part of 'save_admin_settings_cubit.dart';

@immutable
sealed class SaveAdminSettingsState {}

final class SaveAdminSettingsInitial extends SaveAdminSettingsState {}

final class SaveAdminSettingsLoading extends SaveAdminSettingsState {}

final class SaveAdminSettingsSuccess extends SaveAdminSettingsState {}

final class SaveAdminSettingsError extends SaveAdminSettingsState {
  final String message;

  SaveAdminSettingsError({required this.message});
}
