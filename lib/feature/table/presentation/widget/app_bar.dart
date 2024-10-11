import 'package:balibo_station/feature/admin_settings/presentation/bloc/get/get_admin_settings_bloc.dart';
import 'package:balibo_station/feature/table/presentation/widget/select_bluetooth_devices_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TablesPageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Masalar'),
      actions: [
        BlocBuilder<GetAdminSettingsBloc, GetAdminSettingsState>(
          builder: (context, state) {
            if (state is GetAdminSettingsSuccess &&
                (state.settings.canPrintReceipt ?? false)) {
              return IconButton(
                onPressed: () async {
                  SelectBlutoothDevicesDialog.show(context);
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.blueGrey.withOpacity(.2),
                  radius: 30,
                  child: Icon(
                    Icons.print,
                    color: Colors.black.withOpacity(.6),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
