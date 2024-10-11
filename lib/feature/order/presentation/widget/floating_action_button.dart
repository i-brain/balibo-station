import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/core/helper_functions.dart';
import 'package:balibo_station/feature/station/presentation/bloc/get_current_station/get_current_station_bloc.dart';
import 'package:balibo_station/feature/table/presentation/page/tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPageFloatingActionButton extends StatelessWidget {
  const OrdersPageFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentStationBloc, GetCurrentStationState>(
      builder: (context, state) {
        if (state is GetCurrentStationSuccess) {
          return state.station.role == 1
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  onPressed: () => pushPage(context, const TablesPage()),
                  label: Text(
                    'Masalar',
                    style: context.style.titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                )
              : const SizedBox.shrink();
        }
        if (state is GetCurrentStationFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
