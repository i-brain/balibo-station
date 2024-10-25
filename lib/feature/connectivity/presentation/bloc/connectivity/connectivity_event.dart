part of 'connectivity_bloc.dart';

@immutable
sealed class ConnectivityEvent {}

final class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> connectivity;

  ConnectivityChanged({required this.connectivity});
}
