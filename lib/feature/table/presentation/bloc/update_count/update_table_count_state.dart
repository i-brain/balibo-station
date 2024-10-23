part of 'update_table_count_bloc.dart';

@immutable
abstract class UpdateTableCountState {}

class UpdateTableCountInitial extends UpdateTableCountState {}

class UpdateTableCountLoading extends UpdateTableCountState {}

class UpdateTableCountSuccess extends UpdateTableCountState {}

class UpdateTableCountFailure extends UpdateTableCountState {
  final String message;

  UpdateTableCountFailure({required this.message});
}
