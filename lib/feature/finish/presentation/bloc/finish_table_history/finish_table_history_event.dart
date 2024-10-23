part of 'finish_table_history_bloc.dart';

@immutable
sealed class FinishTableHistoryEvent {}

final class FinishTableHistory extends FinishTableHistoryEvent {
  final TableHistory tableHistory;

  FinishTableHistory({required this.tableHistory});
}
