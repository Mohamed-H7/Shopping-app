import 'package:alisveris/utils/bindings/generel_bindings.dart';
import 'package:alisveris/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/constans/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: GenerelBindings(),
      home: const Scaffold(
          backgroundColor: TColors.primary,
          body: Center(
            child: CircularProgressIndicator(color: Colors.white),
          )),
      //const LoginScreen()
      //CircularProgressIndicator(color: Colors.white)
    );
  }
}
