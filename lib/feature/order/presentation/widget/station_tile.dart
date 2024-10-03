import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StationTile extends StatelessWidget {
  const StationTile({
    super.key,
    required this.table,
    required this.productName,
    required this.productCount,
    required this.onDismissed,
  });

  final String table;
  final String productName;
  final int productCount;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(table + productName),
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4).r,
        child: const ColoredBox(color: Colors.green),
      ),
      onDismissed: onDismissed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4).r,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 0, 4).r,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        table,
                        style: context.style.bodyMedium,
                      ),
                      Text(
                        '$productName x $productCount',
                        style: context.style.titleMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8).r,
                  child: Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 255, 157, 59),
                    size: 20.r,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
