import 'package:balibo_station/feature/station/model/station.dart';
import 'package:balibo_station/feature/station/presentation/bloc/get/get_stations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectStationDropdown extends StatelessWidget {
  const SelectStationDropdown({super.key, required this.onChange});

  final void Function(Station? value) onChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStationsBloc, GetStationsState>(
      builder: (context, state) {
        if (state is GetStationsSuccess) {
          return SizedBox(
            width: double.maxFinite,
            child: Center(
              child: DropdownButton<Station>(
                hint: const Text('Stansiya'),
                items: state.stations.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    );
                  },
                ).toList(),
                onChanged: onChange,
              ),
            ),
          );
        }
        if (state is GetStationsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetStationsFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
