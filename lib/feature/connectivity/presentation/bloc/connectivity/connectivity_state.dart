part of 'connectivity_bloc.dart';

@immutable
sealed class ConnectivityState {}

final class ConnectivityInitial extends ConnectivityState {}

final class ConnectivityNone extends ConnectivityState {}

final class ConnectivityInternetConnection extends ConnectivityState {}
