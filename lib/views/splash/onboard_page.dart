import 'package:si_bima/routes/pages.dart';
import 'package:si_bima/services/service_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white, 
      body: _body());
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Container(
          height: Get.height,
          constraints: BoxConstraints(
            maxHeight: Get.height,
            maxWidth: Get.width,
          ),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              _logo(),
              _textContent(),
              _btnStart()
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment(-0.1, -0.15),
      child: Image.asset(
        "assets/images/logo.png",
        width: Get.width * 0.6,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textContent() {
    return Text(
      "Aplikasi pelayanan informasi digital Bapas Kelas II Madiun untuk memudahkan dalam pencarian informasi tentang Klien Pemasyarakatan, serta untuk pengecekan status Klien Pemasyarakatan",
      textAlign: TextAlign.center,
    );
  }

  Widget _btnStart() {
    return Container(
      width: Get.width / 1.4,
      child: GetPlatform.isIOS
          ? CupertinoButton.filled(
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                PreferenceService.setStatus("No First");
                Get.offNamed(AppPages.HOME);
              },
              child: Text('Mulai'),
            )
          : ElevatedButton(
              onPressed: () {
                PreferenceService.setStatus("No First");
                Get.offNamed(AppPages.HOME);
              },
              child: Text('Mulai'),
            ),
    );
  }
}
