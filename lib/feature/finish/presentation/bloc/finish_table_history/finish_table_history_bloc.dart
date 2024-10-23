import 'dart:developer';

import 'package:balibo_station/feature/admin_settings/service/admin_settings.dart';
import 'package:balibo_station/feature/finish/service/finish_table_history.dart';
import 'package:balibo_station/feature/receipt/service/printer_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';

part 'finish_table_history_event.dart';
part 'finish_table_history_state.dart';

class FinishTableHistoryBloc
    extends Bloc<FinishTableHistoryEvent, FinishTableHistoryState> {
  final FinishTableHistoryService _finishTableHistoryService;
  final PrinterService _printerService;
  final AdminSettingsService _adminSettingsService;

  FinishTableHistoryBloc({
    required FinishTableHistoryService finishTableHistoryService,
    required PrinterService printerService,
    required AdminSettingsService adminSettingsService,
  })  : _adminSettingsService = adminSettingsService,
        _printerService = printerService,
        _finishTableHistoryService = finishTableHistoryService,
        super(FinishTableHistoryInitial()) {
    on<FinishTableHistory>(_finishTableHistory);
  }

  Future<void> _finishTableHistory(
    FinishTableHistory event,
    Emitter<FinishTableHistoryState> emit,
  ) async {
    try {
      emit(FinishTableHistoryLoading());

      await _finishTableHistoryService.finish(event.tableHistory);
      if (_adminSettingsService.adminSettings.canPrintReceipt ?? false) {
        _printerService.printTicket(
          isCard: false,
          receipt: event.tableHistory,
        );
      }

      emit(FinishTableHistorySuccess());
    } catch (e) {
      log(e.toString());
      emit(FinishTableHistoryError(errorMessage: e.toString()));
    }
  }
}
