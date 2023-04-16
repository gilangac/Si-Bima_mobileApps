// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/controllers/home/detail_info_controller.dart';
import 'package:si_bima/widgets/general/card_data.dart';

class PresensiScreen extends StatelessWidget {
  PresensiScreen({Key? key}) : super(key: key);
  DetailInfoController detailInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Container(
          height: Get.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: AppColors.primaryColor,
              ),
              _appBar(),
              _body(),
              _fab()
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _appBar() {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  GetPlatform.isIOS ? Feather.chevron_left : Feather.arrow_left,
                  size: 32,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
            Text("Presensi",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
        child: Obx(
      () => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            DataCard(data: detailInfoController.data.value, isViewOnly: true),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi",
                    style: GoogleFonts.poppins(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1.5),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(detailInfoController.presensiLocation.value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Foto Wajah",
                    style: GoogleFonts.poppins(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () => detailInfoController.getImage(),
                    child: Container(
                      height: Get.height * 0.35,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5),
                        color: Colors.white,
                      ),
                      child: detailInfoController.selectedImagePath.value != ''
                          ? Stack(
                              children: [
                                Container(
                                  height: Get.height * 0.35,
                                  width: Get.width,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                          fit: BoxFit.contain,
                                          width: Get.width,
                                          image: FileImage(File(
                                              detailInfoController
                                                  .selectedImagePath.value)))),
                                ),
                                Positioned(
                                    top: 6,
                                    right: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        detailInfoController
                                            .selectedImagePath.value = '';
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Feather.trash,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ))
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Feather.camera,
                                    size: 20,
                                    color: AppColors.grey,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text("Ambil Foto",
                                      style: GoogleFonts.poppins(
                                          color: AppColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _fab() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        width: Get.width - 80,
        child: ElevatedButton(
          onPressed: () {
            detailInfoController.onSendPresensi();
          },
          child: Text("PRESENSI",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
