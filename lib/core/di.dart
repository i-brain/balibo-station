import 'package:balibo_station/common/hive_service.dart';
import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/finish/service/finish_table_history.dart';
import 'package:balibo_station/feature/login/service/login.dart';
import 'package:balibo_station/feature/login/service/user.dart';
import 'package:balibo_station/feature/order/service/order.dart';
import 'package:balibo_station/feature/receipt/service/printer_service.dart';
import 'package:balibo_station/feature/station/service/station.dart';
import 'package:balibo_station/feature/table/service/table.dart';
import 'package:balibo_station/feature/table/service/table_history.dart';
import 'package:balibo_station/feature/table/service/table_history_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
  getIt.registerLazySingleton<AdminService>(
    () => AdminService(storage: getIt()),
  );
  getIt.registerLazySingleton<UserService>(
    () => UserService(storage: getIt()),
  );
  getIt.registerLazySingleton<LoginService>(
    () => LoginService(adminService: getIt(), userService: getIt()),
  );
  getIt.registerLazySingleton<StationService>(
    () => StationService(adminService: getIt(), userService: getIt()),
  );
  getIt.registerLazySingleton<OrderService>(
    () => OrderService(adminService: getIt(), userService: getIt()),
  );
  getIt.registerLazySingleton<TableService>(
    () => TableService(adminService: getIt()),
  );
  getIt.registerLazySingleton<TableHistoryItemService>(
    () => TableHistoryItemService(adminService: getIt()),
  );
  getIt.registerLazySingleton<TableHistoryService>(
    () => TableHistoryService(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerLazySingleton<PrinterService>(
    () => PrinterService(hiveService: getIt()),
  );
  getIt.registerLazySingleton<FinishTableHistoryService>(
    () => FinishTableHistoryService(
      printerService: getIt(),
      tableHistoryService: getIt(),
      tableService: getIt(),
    ),
  );
}
