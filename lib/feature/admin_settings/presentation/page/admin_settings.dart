import 'package:balibo_station/core/di.dart';
import 'package:balibo_station/feature/admin_settings/model/admin_settings.dart';
import 'package:balibo_station/feature/admin_settings/presentation/cubit/save/save_admin_settings_cubit.dart';
import 'package:balibo_station/feature/admin_settings/service/admin_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  static Widget navigate() {
    return BlocProvider(
      create: (context) => SaveAdminSettingsCubit(getIt()),
      child: const AdminSettingsPage(),
    );
  }

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  late final ValueNotifier _printReceiptValue;
  @override
  void initState() {
    super.initState();
    _printReceiptValue =
        ValueNotifier(getIt<AdminSettingsService>().fetch().canPrintReceipt);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Print receipt'),
                        ValueListenableBuilder(
                          valueListenable: _printReceiptValue,
                          builder: (_, value, __) {
                            return Checkbox(
                              value: value,
                              onChanged: (value) {
                                _printReceiptValue.value =
                                    !_printReceiptValue.value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    final adminSettingsModel = AdminSettingsModel(
                        canPrintReceipt: _printReceiptValue.value);

                    context
                        .read<SaveAdminSettingsCubit>()
                        .save(adminSettingsModel);
                  },
                  child: const Center(child: Text('Save')),
                ),
              )
            ],
          ),
        ),
        BlocConsumer<SaveAdminSettingsCubit, SaveAdminSettingsState>(
          listener: (context, state) {
            if (state is SaveAdminSettingsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Yaddaşa yazıldı')));
            }
          },
          builder: (context, state) {
            if (state is SaveAdminSettingsLoading) {
              return ColoredBox(
                color: Colors.white.withOpacity(0.64),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
