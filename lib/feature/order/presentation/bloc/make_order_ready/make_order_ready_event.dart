part of 'make_order_ready_bloc.dart';

@immutable
abstract class MakeOrderReadyEvent {}

class MakeOrderReady extends MakeOrderReadyEvent {
  final String orderId;

  MakeOrderReady({required this.orderId});
}
