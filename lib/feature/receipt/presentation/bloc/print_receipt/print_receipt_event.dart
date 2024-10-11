part of 'print_receipt_bloc.dart';

abstract class PrintReceiptEvent {}

@immutable
class PrintReceipt extends PrintReceiptEvent {
  final TableHistory tableHistory;

  PrintReceipt({required this.tableHistory});
}
