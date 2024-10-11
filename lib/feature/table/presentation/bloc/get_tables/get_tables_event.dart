part of 'get_tables_bloc.dart';

@immutable
abstract class GetTablesEvent {}

class _GetTablesDone extends GetTablesEvent {
  final List<TableModel> tables;
  _GetTablesDone({required this.tables});
}

class _GetTablesError extends GetTablesEvent {
  final String message;
  _GetTablesError({required this.message});
}
