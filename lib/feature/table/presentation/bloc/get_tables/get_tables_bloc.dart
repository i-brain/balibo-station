import 'dart:async';

import 'package:balibo_station/feature/table/model/table.dart';
import 'package:balibo_station/feature/table/service/table.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'get_tables_event.dart';
part 'get_tables_state.dart';

class GetTablesBloc extends Bloc<GetTablesEvent, GetTablesState> {
  GetTablesBloc(this._tableService) : super(GetTablesInitial()) {
    _getTableSubscription = _tableService.getTables().listen((tables) {
      add(_GetTablesDone(tables: tables));
    }, onError: (error) {
      add(_GetTablesError(message: error.toString()));
    });
    on<_GetTablesDone>(_done);
    on<_GetTablesError>(_error);
  }

  final TableService _tableService;
  StreamSubscription<List<TableModel>>? _getTableSubscription;

  Future<void> _done(
    _GetTablesDone event,
    Emitter<GetTablesState> emit,
  ) async {
    emit(GetTablesSuccess(tables: event.tables));
  }

  Future<void> _error(
    _GetTablesError event,
    Emitter<GetTablesState> emit,
  ) async {
    emit(GetTablesFailure(message: event.message));
  }

  @override
  Future<void> close() {
    _getTableSubscription?.cancel();
    return super.close();
  }
}
