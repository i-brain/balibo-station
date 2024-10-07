import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/core/helper_functions.dart';
import 'package:balibo_station/feature/table/presentation/page/finish_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableCard extends StatelessWidget {
  const TableCard({
    super.key,
    required this.tableNumber,
    required this.isActive,
  });

  final int tableNumber;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4).r,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: isActive ? Colors.blue[100] : Colors.red[100],
          type: MaterialType.button,
          child: InkWell(
            onTap: () =>
                pushPage(context, FinishTablePage.navigate(tableNumber)),
            splashColor: Colors.green.withOpacity(0.2),
            child: Center(
              child: Text(
                'Masa - $tableNumber',
                style: context.style.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
