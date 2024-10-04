part of 'get_orders_bloc.dart';

@immutable
abstract class GetOrdersEvent {}

class _GetOrdersDone extends GetOrdersEvent {
  final List<OrderItem> orders;

  _GetOrdersDone({required this.orders});
}

class _GetOrdersError extends GetOrdersEvent {
  final String message;

  _GetOrdersError({required this.message});
}
