import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/FirstScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:pwa_install/pwa_install.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PWAInstall().setup(installCallback: () {
    debugPrint('APP INSTALLED!');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirstScreen(),
        );
      },
    );
  }
}
