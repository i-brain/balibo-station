part of 'get_tables_bloc.dart';

@immutable
abstract class GetTablesState {}

class GetTablesInitial extends GetTablesState {}

class GetTablesSuccess extends GetTablesState {
  final List<TableModel> tables;
  GetTablesSuccess({required this.tables});
}

class GetTablesFailure extends GetTablesState {
  final String message;
  GetTablesFailure({required this.message});
}
