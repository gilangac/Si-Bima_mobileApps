import 'package:si_bima/routes/pages.dart';
import 'package:si_bima/services/service_preference.dart';
import 'package:si_bima/themes/light_theme.dart';
import 'package:si_bima/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await PreferenceService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Si-Bima',
      theme: lightTheme(context),
      initialRoute: AppRoutes.INITIAL,
      home: HomeScreen(),
      getPages: AppRoutes.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
