import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/core/helper_functions.dart';
import 'package:balibo_station/feature/order/presentation/widget/station_tile.dart';
import 'package:balibo_station/feature/table/presentation/page/tables_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sifarişlər')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => pushPage(context, const TablesPage()),
        label: Text(
          'Masalar',
          style: context.style.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0).r,
        itemBuilder: (context, index) => StationTile(
          table: 'Masa 1',
          productName: 'Xırdalan 0.5',
          productCount: 2,
          onDismissed: (_) {},
        ),
      ),
    );
  }
}
