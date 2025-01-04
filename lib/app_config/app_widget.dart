import 'package:app_milli/app_config/const/scroll.dart' as controller;
import 'package:app_milli/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      scrollBehavior: controller.ScrollController(),
      home: const HomePage(),
    );
  }
}
