import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsRow extends StatelessWidget {
  const ProductDetailsRow({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
  });
  final String name;
  final double price;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: context.style.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '${quantity}x${price.toStringAsFixed(2)} ₼ = ${(quantity * price).toStringAsFixed(2)} ₼',
          style: context.style.titleMedium,
        ),
      ],
    );
  }
}
