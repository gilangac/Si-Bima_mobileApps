// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:si_bima/constant/colors.dart';

class SnackBarHelper {
  static showError({required String description, SnackPosition? position}) {
    Get.showSnackbar(
      GetBar(
        icon: SvgPicture.asset(
          "assets/svg/close-circle.svg",
          color: Colors.white,
          height: 16,
        ),
        backgroundColor: AppColors.red,
        message: description,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: position ?? SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        borderRadius: 4,
        mainButton: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Feather.x,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static showSucces({required String description, SnackPosition? position}) {
    Get.showSnackbar(
      GetBar(
        icon: SvgPicture.asset(
          "assets/svg/check-circle.svg",
          color: Colors.white,
          height: 16,
        ),
        backgroundColor: Colors.green.withOpacity(1),
        message: description,
        duration: const Duration(seconds: 3),
        mainButton: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Feather.x,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: position ?? SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        borderRadius: 4,
      ),
    );
  }
}
