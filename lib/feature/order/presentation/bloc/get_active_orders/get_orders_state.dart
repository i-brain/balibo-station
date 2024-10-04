part of 'get_orders_bloc.dart';

@immutable
abstract class GetOrdersState {}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersSuccess extends GetOrdersState {
  final List<OrderItem> orders;

  GetOrdersSuccess({required this.orders});
}

class GetOrdersFailure extends GetOrdersState {
  final String message;

  GetOrdersFailure({required this.message});
}
