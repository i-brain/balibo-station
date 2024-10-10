import 'package:balibo_station/common/hive_service.dart';
import 'package:balibo_station/feature/admin_settings/model/admin_settings.dart';

class AdminSettingsService {
  final HiveService _hiveService;

  AdminSettingsService({required HiveService hiveService})
      : _hiveService = hiveService;

  Future<void> save(AdminSettingsModel adminSettingsModel) async {
    await _hiveService.savePrintReceipt(adminSettingsModel.canPrintReceipt);
  }

  AdminSettingsModel fetch() {
    return AdminSettingsModel(canPrintReceipt: _hiveService.printReceipt);
  }
}
