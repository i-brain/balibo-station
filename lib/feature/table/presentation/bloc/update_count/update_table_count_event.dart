part of 'update_table_count_bloc.dart';

@immutable
abstract class UpdateTableCountEvent {}

class UpdateTableCount extends UpdateTableCountEvent {
  final int previousCount;
  final int newCount;

  UpdateTableCount({required this.previousCount, required this.newCount});
}
