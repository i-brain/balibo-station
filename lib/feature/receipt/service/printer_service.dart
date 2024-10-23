import 'package:balibo_station/common/hive_service.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:intl/intl.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:test_pack/bluetooth_thermal_printer.dart';

class PrinterService {
  final HiveService _hiveService;

  PrinterService({required HiveService hiveService})
      : _hiveService = hiveService;

  Future<void> printTicket({
    required bool isCard,
    String? subtitle,
    required TableHistory receipt,
  }) async {
    String? isConnected = '';
    // await BluetoothThermalPrinter.connectionStatus;

    // if (isConnected != 'true') {
    //   await BluetoothThermalPrinter.connect('DC:0D:30:54:DB:7D');
    // }
    isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getTicket(
        isCard: isCard,
        receipt: receipt,
        subtitle: subtitle,
      );
      await BluetoothThermalPrinter.writeBytes(bytes);
      // print("Print $result");
    } else {
      if (_hiveService.printerUrl.isNotEmpty) {
        final res = await _setConnect(_hiveService.printerUrl);
        if (res) {
          printTicket(
            isCard: isCard,
            receipt: receipt,
          );
        }
      }
    }
  }

  Future<List<int>> getTicket({
    required bool isCard,
    String? subtitle,
    required TableHistory receipt,
  }) async {
    final now = DateTime.now();
    final dateFormatter = DateFormat('dd MM yyyy');
    final dateString = dateFormatter.format(now);

    final timeFormatter = DateFormat('HH:mm:ss');
    final timeString = timeFormatter.format(now);
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    bytes += generator.text("Satis senedi",
        styles: const PosStyles(align: PosAlign.center));

    // bytes += generator.text('Cek nomresi: ${checkNumber.toUpperCase()}',
    //     styles: const PosStyles(align: PosAlign.center));

    bytes += generator.row([
      PosColumn(
          text: 'Tarix: $dateString',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
          )),
      PosColumn(
          text: 'Saat: $timeString',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
          ))
    ]);
    bytes += generator.hr();

    if (receipt.items.isNotEmpty) {
      bytes += generator.row([
        PosColumn(
            text: 'Malin adi',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.left,
            )),
        PosColumn(
            text: 'Miqdar',
            width: 2,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
        PosColumn(
            text: 'Qiymet',
            width: 2,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
        PosColumn(
            text: 'Toplam',
            width: 2,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
      ]);
      for (var product in receipt.items) {
        final amount = product.quantity;
        final total = (product.price.toDouble() * amount).toStringAsFixed(2);
        bytes += generator.row([
          PosColumn(
              text: product.name,
              width: 6,
              styles: const PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: '$amount',
              width: 2,
              styles: const PosStyles(
                align: PosAlign.right,
              )),
          PosColumn(
              text: product.price.toDouble().toStringAsFixed(2),
              width: 2,
              styles: const PosStyles(align: PosAlign.right)),
          PosColumn(
              text: total,
              width: 2,
              styles: const PosStyles(align: PosAlign.right)),
        ]);
      }

      bytes += generator.hr();
      bytes += generator.row([
        PosColumn(
            text: 'YEKUN MEBLEQ',
            width: 7,
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: receipt.sum.toStringAsFixed(2),
            width: 5,
            styles: const PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
      ]);
    }

    bytes += generator.hr(ch: '=');

    bytes += generator.text('Tesekkur Edirik!!!',
        styles: const PosStyles(
          align: PosAlign.center,
        ));

    bytes += generator.cut();
    return bytes;
  }

  static Future<bool> _setConnect(String mac) async {
    final String? result = await BluetoothThermalPrinter.connect(mac);
    if (result == "true") {
      return true;
    }
    return false;
  }
}
