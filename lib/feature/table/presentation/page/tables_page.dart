import 'package:balibo_station/core/helper_functions.dart';
import 'package:balibo_station/feature/table/presentation/page/finish_table_page.dart';
import 'package:flutter/material.dart';
import '../widget/table_tile.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masalar')),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => TableTile(
          table: 'Masa 1',
          onTap: () => pushPage(context, const FinishTablePage()),
        ),
      ),
    );
  }
}
