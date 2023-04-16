import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/helpers/snackbar_helper.dart';
import 'package:si_bima/utils/date_time_utils.dart';

class DialogHelper {
  static showLoading() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/json/loading.json',
                width: 120,
                height: 120,
                fit: BoxFit.fill,
              ),
              Text(
                'Mohon Tunggu...',
                style:
                    GoogleFonts.poppins(fontSize: 14, color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

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

  static showDateVerification(
      {String? title,
      String? description,
      required Function(String date) action,
      required TextEditingController textController}) {
    String dateSelected = '';
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? 'Peringatan',
                  style: GoogleFonts.poppins(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/validate_date.png',
                  height: 160,
                  fit: BoxFit.fill,
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Feather.calendar, color: Colors.grey.shade400),
                    hintText: 'Pilih tanggal lahir',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1.5),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? dateBirth =
                        await DateTimeUtils.selectDate(Get.context!);
                    textController.text =
                        DateFormat('dd/MM/yyyy').format(dateBirth!);
                    dateSelected = DateFormat('ddMMyyyy').format(dateBirth);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        SnackBarHelper.showError(
                            description: "Field tanggal lahir harus diisi !");
                      } else {
                        if (Get.isDialogOpen ?? false) Get.back();
                        action(dateSelected);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child:
                       Text('Lanjutkan')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
