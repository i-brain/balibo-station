import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/core/helper_functions.dart';
import 'package:balibo_station/feature/order/presentation/bloc/get_active_orders/get_orders_bloc.dart';
import 'package:balibo_station/feature/order/presentation/bloc/make_order_ready/make_order_ready_bloc.dart';
import 'package:balibo_station/feature/order/presentation/widget/orders_list_widget.dart';
import 'package:balibo_station/feature/station/presentation/bloc/get_current_station/get_current_station_bloc.dart';
import 'package:balibo_station/feature/table/presentation/page/tables_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static Widget navigate() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCurrentStationBloc(getIt()),
        ),
        BlocProvider(
          create: (context) => GetActiveOrdersBloc(getIt()),
        ),
        BlocProvider(
          create: (context) => GetReadyOrdersBloc(getIt()),
        ),
        BlocProvider(
          create: (context) => MakeOrderReadyBloc(getIt()),
        ),
      ],
      child: const OrdersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('Sifarişlər')),
          floatingActionButton:
              BlocBuilder<GetCurrentStationBloc, GetCurrentStationState>(
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
          ),
          body: const OrdersListWidget(),
        ),
        BlocBuilder<MakeOrderReadyBloc, MakeOrderReadyState>(
          builder: (context, state) {
            if (state is MakeOrderReadyLoading) {
              return ColoredBox(
                color: Colors.white.withOpacity(0.64),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
