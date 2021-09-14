import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DialogHelper {

  static showError({String? title, String? description}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? 'Peringatan',
                style: Get.textTheme.headline4,
              ),
              Lottie.asset(
                'assets/json/no_internet.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
              Text(
                description ?? 'Sorry, something went wrong',
                style: Get.textTheme.bodyText1,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onPressed: () {
                    if (Get.isDialogOpen ?? false) Get.back();
                  },
                  child: Text('Okay'))
            ],
          ),
        ),
      ),
    );
  }
}
