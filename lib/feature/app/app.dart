import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/theme.dart';
import '../order/presentation/page/orders_page.dart';

class StationApp extends StatelessWidget {
  const StationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 812),
      builder: (context, child) => MaterialApp(
        title: 'Balibo',
        theme: AppTheme.theme,
        home: const OrdersPage(),
      ),
    );
  }
}
