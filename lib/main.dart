import 'dart:io';
import 'package:attendx/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:attendx/views/auth/auth_wapper_view.dart';
import 'package:provider/provider.dart';

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const MyApp());
    });
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(value: AuthController()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Attend KCU",
        theme: ThemeData(primaryColor: Color(0xff021D49)),
        home: const AuthWrapperView(),
      ),
    );
  }
}
