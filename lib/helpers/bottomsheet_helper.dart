import 'package:si_bima/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class BottomSheetHelper {
  static showError(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContent(
        title, description, textAction, Category.error, onAction);
  }

  static showSuccess(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContent(
        title, description, textAction, Category.success, onAction);
  }
}

void _bottomSheetContent(
    String title, String description, String? textAction, Category category,
    [void Function()? onAction]) {
  Get.bottomSheet(
    SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Get.textTheme.headline5,
            ),
            SizedBox(height: 40),
            Image.asset(
              (category == Category.success)
                  ? 'assets/images/logo.png'
                  : 'assets/images/logo.png',
              height: 90,
            ),
            SizedBox(height: 20),
            Text(
              description,
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              child: GetPlatform.isIOS
                  ? CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(12),
                      onPressed: onAction ?? _onPressCTA,
                      child: Text(textAction ?? 'Oke'),
                    )
                  : ElevatedButton(
                      onPressed: onAction ?? _onPressCTA,
                      child: Text(textAction ?? 'Oke'),
                    ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
  );
}

_onPressCTA() {
  if (Get.isBottomSheetOpen!) Get.back();
  Get.back();
}

enum Category { success, error }
