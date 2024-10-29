part of 'make_order_ready_bloc.dart';

@immutable
abstract class MakeOrderReadyEvent {}

class MakeOrderReady extends MakeOrderReadyEvent {
  final String orderId;
  final String id;

  MakeOrderReady({required this.orderId, required this.id});
}
