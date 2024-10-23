part of 'get_table_history_bloc.dart';

@immutable
abstract class GetTableHistoryState {}

final class GetTableHistoryInitial extends GetTableHistoryState {}

final class GetTableHistoryLoading extends GetTableHistoryState {}

final class GetTableHistorySuccess extends GetTableHistoryState {
  final TableHistory tableHistory;

  GetTableHistorySuccess({required this.tableHistory});
}

final class GetTableHistoryFailure extends GetTableHistoryState {
  final String errorMessage;

  GetTableHistoryFailure({required this.errorMessage});
}
