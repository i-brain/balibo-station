part of 'print_receipt_bloc.dart';

@immutable
abstract class PrintReceiptState {}

class PrintReceiptInitial extends PrintReceiptState {}

class PrintReceiptSuccess extends PrintReceiptState {}

class PrintReceiptLoading extends PrintReceiptState {}

class PrintReceiptError extends PrintReceiptState {
  final String errorMessage;

  PrintReceiptError({required this.errorMessage});
}
