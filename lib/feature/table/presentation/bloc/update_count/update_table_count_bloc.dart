import 'package:balibo_station/feature/table/service/table.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'update_table_count_event.dart';
part 'update_table_count_state.dart';

class UpdateTableCountBloc
    extends Bloc<UpdateTableCountEvent, UpdateTableCountState> {
  final TableService _tableService;

  UpdateTableCountBloc(this._tableService) : super(UpdateTableCountInitial()) {
    on<UpdateTableCount>(_updateTableCount);
  }

  Future<void> _updateTableCount(
      UpdateTableCount event, Emitter<UpdateTableCountState> emit) async {
    try {
      emit(UpdateTableCountLoading());
      await _tableService.updateTableCount(event.previousCount, event.newCount);
      emit(UpdateTableCountSuccess());
    } catch (e) {
      emit(UpdateTableCountFailure(message: e.toString()));
    }
  }
}
