import 'package:balibo_station/feature/finish/presentation/bloc/bloc/finish_table_history_bloc.dart';
import 'package:balibo_station/feature/table/model/table_history.dart';
import 'package:balibo_station/feature/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishTableHistoryButton extends StatelessWidget {
  const FinishTableHistoryButton({
    super.key,
    required this.tableHistory,
  });

  final TableHistory tableHistory;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Bitir',
      onTap: () => context
          .read<FinishTableHistoryBloc>()
          .add(FinishTableHistory(tableHistory: tableHistory)),
      backgroundColor: Colors.green,
    );
  }
}
