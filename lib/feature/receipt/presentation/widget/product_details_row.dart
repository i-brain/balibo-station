import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProductDetailsRow extends StatelessWidget {
  const ProductDetailsRow({
    super.key,
    this.name,
    this.price,
    this.quantity,
  });
  final String? name;
  final double? price;
  final int? quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name ?? 'Məhsul',
            style: context.style.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: _Text(quantity?.toString() ?? 'Miqdar'),
        ),
        Expanded(
          child: _Text(price?.toStringAsFixed(2) ?? 'Qiymət'),
        ),
        Expanded(
          child: _Text(price == null || quantity == null
              ? 'Məbləq'
              : (quantity! * price!).toStringAsFixed(2)),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: context.style.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
