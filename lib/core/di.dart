import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/login/service/login.dart';
import 'package:balibo_station/feature/login/service/user.dart';
import 'package:balibo_station/feature/order/service/order.dart';
import 'package:balibo_station/feature/station/service/station.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
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
}
