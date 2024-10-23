part of 'make_order_ready_bloc.dart';

@immutable
abstract class MakeOrderReadyState {}

class MakeOrderReadyInitial extends MakeOrderReadyState {}

class MakeOrderReadyLoading extends MakeOrderReadyState {}

class MakeOrderReadySuccess extends MakeOrderReadyState {}

class MakeOrderReadyFailure extends MakeOrderReadyState {
  final String message;

  MakeOrderReadyFailure({required this.message});
}
