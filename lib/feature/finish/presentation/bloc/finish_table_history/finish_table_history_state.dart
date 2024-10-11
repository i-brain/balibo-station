part of 'finish_table_history_bloc.dart';

@immutable
sealed class FinishTableHistoryState {}

final class FinishTableHistoryInitial extends FinishTableHistoryState {}

final class FinishTableHistoryLoading extends FinishTableHistoryState {}

final class FinishTableHistorySuccess extends FinishTableHistoryState {}

final class FinishTableHistoryError extends FinishTableHistoryState {
  final String errorMessage;

  FinishTableHistoryError({required this.errorMessage});
}
