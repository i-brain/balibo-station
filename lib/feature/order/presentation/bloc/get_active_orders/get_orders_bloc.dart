import 'dart:async';

import 'package:balibo_station/feature/order/model/order_item.dart';
import 'package:balibo_station/feature/order/service/order.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_orders_event.dart';
part 'get_orders_state.dart';

class GetActiveOrdersBloc extends Bloc<GetOrdersEvent, GetOrdersState> {
  GetActiveOrdersBloc(this._orderService) : super(GetOrdersInitial()) {
    _getOrdersSubscription = _orderService.getActiveOrders().listen((orders) {
      add(_GetOrdersDone(orders: orders));
    }, onError: (error) {
      add(_GetOrdersError(message: error.toString()));
    });
    on<_GetOrdersDone>(_done);
    on<_GetOrdersError>(_error);
  }

  final OrderService _orderService;
  StreamSubscription<List<OrderItem>>? _getOrdersSubscription;

  Future<void> _done(
    _GetOrdersDone event,
    Emitter<GetOrdersState> emit,
  ) async {
    emit(GetOrdersSuccess(orders: event.orders));
  }

  Future<void> _error(
    _GetOrdersError event,
    Emitter<GetOrdersState> emit,
  ) async {
    emit(GetOrdersFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _getOrdersSubscription?.cancel();
    return super.close();
  }
}

class GetReadyOrdersBloc extends Bloc<GetOrdersEvent, GetOrdersState> {
  GetReadyOrdersBloc(this._orderService) : super(GetOrdersInitial()) {
    _getOrdersSubscription = _orderService.getReadyOrders().listen((orders) {
      add(_GetOrdersDone(orders: orders));
    }, onError: (error) {
      add(_GetOrdersError(message: error.toString()));
    });
    on<_GetOrdersDone>(_done);
    on<_GetOrdersError>(_error);
  }

  final OrderService _orderService;
  StreamSubscription<List<OrderItem>>? _getOrdersSubscription;

  Future<void> _done(
    _GetOrdersDone event,
    Emitter<GetOrdersState> emit,
  ) async {
    emit(GetOrdersSuccess(orders: event.orders));
  }

  Future<void> _error(
    _GetOrdersError event,
    Emitter<GetOrdersState> emit,
  ) async {
    emit(GetOrdersFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _getOrdersSubscription?.cancel();
    return super.close();
  }
}
