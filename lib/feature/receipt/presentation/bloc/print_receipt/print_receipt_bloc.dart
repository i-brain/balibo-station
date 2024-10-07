import 'dart:developer';

import 'package:balibo_station/feature/receipt/service/printer_service.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'print_receipt_event.dart';
part 'print_receipt_state.dart';

class PrintReceiptBloc extends Bloc<PrintReceiptEvent, PrintReceiptState> {
  PrintReceiptBloc(this._printerService) : super(PrintReceiptInitial()) {
    on<PrintReceipt>(_print);
  }

  final PrinterService _printerService;

  Future<void> _print(
      PrintReceipt event, Emitter<PrintReceiptState> emit) async {
    try {
      emit(PrintReceiptLoading());
      await _printerService.printTicket(
        isCard: false,
        receipt: event.tableHistory,
      );
      emit(PrintReceiptSuccess());
    } catch (e) {
      log(e.toString());
      emit(PrintReceiptError(errorMessage: e.toString()));
    }
  }
}
