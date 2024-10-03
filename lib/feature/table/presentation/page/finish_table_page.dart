import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/feature/widget/custom_button.dart';
import 'package:balibo_station/feature/table/presentation/widget/product_details_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishTablePage extends StatelessWidget {
  const FinishTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sifariş Məlumatları')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(8).r,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 14,
                      itemBuilder: (context, index) => const ProductDetailsRow(
                        name: 'Xırdalan 0.5',
                        price: 5,
                        quantity: 2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Cəmi: ', style: context.style.titleLarge),
                        Text('30 azn', style: context.style.titleLarge),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              title: 'Bitir',
              onTap: () {},
              backgroundColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
