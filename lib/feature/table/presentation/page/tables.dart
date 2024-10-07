import 'package:balibo_station/feature/table/core/enum/table_history_status.dart';
import 'package:balibo_station/feature/table/presentation/bloc/get_tables/get_tables_bloc.dart';
import 'package:balibo_station/feature/table/presentation/widget/table_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Masalar')),
        body: BlocBuilder<GetTablesBloc, GetTablesState>(
          builder: (context, state) {
            if (state is GetTablesSuccess) {
              final tables = state.tables;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];

                  return TableCard(
                    isActive: table.status == TableStatusEnum.active.value,
                    tableNumber: table.number,
                  );
                },
              );
            }
            if (state is GetTablesFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      );
    });
  }
}
