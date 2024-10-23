import 'package:balibo_station/feature/receipt/service/printer_service.dart';
import 'package:balibo_station/feature/table/core/enum/table_history_status.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:balibo_station/feature/table/service/table.dart';
import 'package:balibo_station/feature/table/service/table_history.dart';

class FinishTableHistoryService {
  final TableHistoryService _tableHistoryService;
  final TableService _tableService;
  final PrinterService _printerService;

  FinishTableHistoryService({
    required TableHistoryService tableHistoryService,
    required TableService tableService,
    required PrinterService printerService,
  })  : _tableHistoryService = tableHistoryService,
        _printerService = printerService,
        _tableService = tableService;

  Future<void> finish(TableHistory tableHistory) async {
    await _tableHistoryService.updateTableHistoryStatus(
      historyId: tableHistory.id!,
      status: TableStatusEnum.deactive,
    );

    await _tableService.updateTableStatusByTableNumber(
      tableHistory.tableNumber,
      TableStatusEnum.deactive,
    );

    await _printerService.printTicket(isCard: false, receipt: tableHistory);
  }
}
