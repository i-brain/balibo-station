part of 'get_table_history_bloc.dart';

@immutable
abstract class GetTableHistoryEvent {}

final class GetTableHistory extends GetTableHistoryEvent {
  final int tableNumber;

  GetTableHistory({required this.tableNumber});
}
