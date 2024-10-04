part of 'get_stations_bloc.dart';

@immutable
sealed class GetStationsState {}

final class GetStationsInitial extends GetStationsState {}

final class GetStationsLoading extends GetStationsState {}

final class GetStationsSuccess extends GetStationsState {
  final List<Station> stations;

  GetStationsSuccess({required this.stations});
}

final class GetStationsFailure extends GetStationsState {
  final String message;

  GetStationsFailure({required this.message});
}
