import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/feature/finish/presentation/bloc/bloc/finish_table_history_bloc.dart';
import 'package:balibo_station/feature/finish/presentation/widget/finish_table_history_button.dart';
import 'package:balibo_station/feature/table/presentation/bloc/get_table_history/get_table_history_bloc.dart';
import 'package:balibo_station/feature/table/presentation/widget/product_details_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishTablePage extends StatelessWidget {
  const FinishTablePage({super.key});

  static Widget navigate(int tableNumber) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetTableHistoryBloc(tableHistoryService: getIt())
            ..add(GetTableHistory(tableNumber: tableNumber)),
        ),
        BlocProvider(
          create: (context) =>
              FinishTableHistoryBloc(finishTableHistoryService: getIt()),
        ),
      ],
      child: const FinishTablePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FinishTableHistoryBloc, FinishTableHistoryState>(
      listener: (context, state) {
        if (state is FinishTableHistorySuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            PopScope(
              canPop: state is! FinishTableHistoryLoading,
              child: Scaffold(
                appBar: AppBar(title: const Text('Sifariş Məlumatları')),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16).r,
                  child: BlocBuilder<GetTableHistoryBloc, GetTableHistoryState>(
                    builder: (context, state) {
                      if (state is GetTableHistorySuccess) {
                        final history = state.tableHistory;
                        return Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.all(8).r,
                                child: Column(
                                  children: [
                                    const ProductDetailsRow(),
                                    const Divider(),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: history.items.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 2.h),
                                      itemBuilder: (context, index) {
                                        final historyItem =
                                            history.items[index];

                                        return ProductDetailsRow(
                                          name: historyItem.name,
                                          price: historyItem.price,
                                          quantity: historyItem.quantity,
                                        );
                                      },
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Cəmi: ',
                                            style: context.style.titleLarge),
                                        Text(
                                          '${history.sum} azn',
                                          style: context.style.titleLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            FinishTableHistoryButton(tableHistory: history),
                          ],
                        );
                      }
                      if (state is GetTableHistoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetTableHistoryFailure) {
                        return Center(child: Text(state.errorMessage));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
            if (state is FinishTableHistoryLoading)
              ColoredBox(
                color: Colors.white.withOpacity(0.64),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
