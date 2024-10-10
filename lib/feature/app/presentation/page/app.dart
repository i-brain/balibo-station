import 'package:balibo_station/feature/app/presentation/widget/app_providers.dart';
import 'package:balibo_station/feature/login/presentation/bloc/login/login_bloc.dart';
import 'package:balibo_station/feature/login/presentation/page/login_page.dart';
import 'package:balibo_station/feature/order/presentation/page/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/theme.dart';

class StationApp extends StatelessWidget {
  const StationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: ScreenUtilInit(
        designSize: const Size(374, 812),
        builder: (context, child) => MaterialApp(
          title: 'Balibo',
          theme: AppTheme.theme,
          home: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                return OrdersPage.navigate();
              }
              if (state is LoginFailure) {
                return const LoginPage();
              }
              if (state is LoginLoading) {
                return const ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}