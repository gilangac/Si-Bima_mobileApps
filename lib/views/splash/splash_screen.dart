import 'dart:async';

import 'package:si_bima/routes/pages.dart';
import 'package:si_bima/services/service_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SreenScreenState createState() => _SreenScreenState();
}

class _SreenScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _onSplash();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height,
          maxWidth: Get.width,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1252459), Color(0xFF0B093C)],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/logo_white.png",
                width: Get.width * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.83),
              child: Image.asset(
                "assets/images/powered_by.png",
                width: Get.width * 0.35,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }

  _onSplash() {
  final status = PreferenceService.getStatus();
    return Timer(Duration(milliseconds: 2500), () {
      if (status == null || status == "") {
        Get.offAllNamed(AppPages.ONBOARDING);
      } else {
        Get.offAllNamed(AppPages.HOME);
      }
    });
  }
}