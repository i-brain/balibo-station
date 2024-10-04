part of 'get_current_station_bloc.dart';

@immutable
abstract class GetCurrentStationState {}

final class GetCurrentStationInitial extends GetCurrentStationState {}

final class GetCurrentStationSuccess extends GetCurrentStationState {
  final Station station;

  GetCurrentStationSuccess({required this.station});
}

final class GetCurrentStationFailure extends GetCurrentStationState {
  final String message;

  GetCurrentStationFailure({required this.message});
}
