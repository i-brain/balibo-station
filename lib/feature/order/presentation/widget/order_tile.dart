import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.table,
    required this.productName,
    required this.productCount,
    required this.isActive,
    required this.username,
    required this.onDismissed,
  });

  final String table;
  final String username;
  final bool isActive;
  final String productName;
  final int productCount;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(table + productName),
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4).r,
        child: ColoredBox(color: Colors.green.withOpacity(isActive ? 1 : 0.5)),
      ),
      confirmDismiss: (direction) {
        onDismissed?.call(direction);
        return Future.value(false);
      },
      direction: isActive ? DismissDirection.endToStart : DismissDirection.none,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8).r,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey.withOpacity(isActive ? 1 : 0.5)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8).r,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            table + ' - ',
                            style: context.style.bodyMedium?.copyWith(
                              color: context.style.bodyMedium?.color
                                  ?.withOpacity(isActive ? 1 : 0.5),
                            ),
                          ),
                          Text(
                            username,
                            style: context.style.titleSmall?.copyWith(
                              color: context.style.bodyMedium?.color
                                  ?.withOpacity(isActive ? 1 : 0.5),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$productName x $productCount',
                        style: context.style.titleMedium?.copyWith(
                          color: context.style.titleMedium?.color
                              ?.withOpacity(isActive ? 1 : 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                isActive
                    ? Icon(
                        Icons.circle,
                        color: const Color.fromARGB(255, 255, 157, 59),
                        size: 26.r,
                      )
                    : Icon(
                        Icons.check_circle,
                        color: Colors.green.withOpacity(0.5),
                        size: 26.r,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
