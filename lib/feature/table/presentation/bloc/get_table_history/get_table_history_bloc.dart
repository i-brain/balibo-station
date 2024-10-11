import 'dart:async';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:balibo_station/feature/table/service/table_history.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_table_history_event.dart';
part 'get_table_history_state.dart';

class GetTableHistoryBloc
    extends Bloc<GetTableHistoryEvent, GetTableHistoryState> {
  final TableHistoryService _tableHistoryService;

  GetTableHistoryBloc({
    required TableHistoryService tableHistoryService,
  })  : _tableHistoryService = tableHistoryService,
        super(GetTableHistoryInitial()) {
    on<GetTableHistory>(_onGetTableHistoryRequested);
  }

  Future<void> _onGetTableHistoryRequested(
    GetTableHistory event,
    Emitter<GetTableHistoryState> emit,
  ) async {
    emit(GetTableHistoryLoading());

    try {
      TableHistory tableHistory =
          await _tableHistoryService.getTableHistory(event.tableNumber);

      emit(GetTableHistorySuccess(tableHistory: tableHistory));
    } catch (e) {
      emit(GetTableHistoryFailure(errorMessage: e.toString()));
    }
  }
}
