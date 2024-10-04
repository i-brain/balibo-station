import 'package:balibo_station/core/extensions/theme_extension.dart';
import 'package:balibo_station/feature/login/model/login.dart';
import 'package:balibo_station/feature/login/presentation/bloc/login/login_bloc.dart';
import 'package:balibo_station/feature/station/model/station.dart';
import 'package:balibo_station/feature/station/presentation/bloc/get/get_stations_bloc.dart';
import 'package:balibo_station/feature/station/presentation/widget/select_station_dropdown.dart';
import 'package:balibo_station/feature/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _adminController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _obscureNotifier;
  Station? _selectedStation;
  @override
  void initState() {
    super.initState();
    _adminController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _adminController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Giriş',
              style: context.style.titleLarge,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _adminController,
              decoration: const InputDecoration(hintText: 'Admin'),
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context
                    .read<GetStationsBloc>()
                    .add(GetStations(adminId: value));
              },
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Ad'),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 8.h),
            ValueListenableBuilder(
              valueListenable: _obscureNotifier,
              builder: (context, obscureText, child) => TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Şifrə',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _obscureNotifier.value = !_obscureNotifier.value;
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: obscureText,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 8.h),
            SelectStationDropdown(
              onChange: (value) {
                _selectedStation = value;
              },
            ),
            SizedBox(height: 16.h),
            CustomButton(
                title: 'Daxil ol',
                onTap: () {
                  context.read<LoginBloc>().add(LoginUser(
                          loginModel: LoginModel(
                        admin: _adminController.text,
                        password: _passwordController.text,
                        username: _nameController.text,
                        stationId: _selectedStation?.id,
                      )));
                }),
          ],
        ),
      ),
    );
  }
}
