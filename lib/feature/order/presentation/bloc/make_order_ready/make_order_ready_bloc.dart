import 'package:balibo_station/feature/order/service/order.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'make_order_ready_event.dart';
part 'make_order_ready_state.dart';

class MakeOrderReadyBloc
    extends Bloc<MakeOrderReadyEvent, MakeOrderReadyState> {
  MakeOrderReadyBloc(this._orderService) : super(MakeOrderReadyInitial()) {
    on<MakeOrderReady>(_makeReady);
  }

  final OrderService _orderService;

  Future<void> _makeReady(
    MakeOrderReady event,
    Emitter<MakeOrderReadyState> emit,
  ) async {
    try {
      emit(MakeOrderReadyLoading());
      await _orderService.makeOrderItemReady(
        orderId: event.orderId,
        id: event.id,
      );
      emit(MakeOrderReadySuccess());
    } catch (e) {
      emit(MakeOrderReadyFailure(message: e.toString()));
    }
  }
}
