import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/feature/login/presentation/bloc/login/login_bloc.dart';
import 'package:balibo_station/feature/station/presentation/bloc/get/get_stations_bloc.dart';
import 'package:balibo_station/feature/table/presentation/bloc/get_tables/get_tables_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(getIt())..add(LoginUser()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GetStationsBloc(getIt()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GetTablesBloc(getIt()),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
