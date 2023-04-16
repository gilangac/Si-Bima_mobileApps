import 'package:animate_do/animate_do.dart';
import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/controllers/home/detail_info_controller.dart';
import 'package:si_bima/helpers/dialog_helper.dart';
import 'package:si_bima/models/person.dart';
import 'package:si_bima/widgets/general/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailInfoScreen extends StatelessWidget {
  DetailInfoScreen({Key? key}) : super(key: key);
  final detailInfoController = Get.put(DetailInfoController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: Obx(() => SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  height: statusBarHeight,
                  color: AppColors.primaryColor,
                ),
                _appBar(),
                SizedBox(height: 15),
                _body(detailInfoController),
              ],
            ),
          )),
      backgroundColor: AppColors.primaryColor,
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
          Text("Detail Klien",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _body(DetailInfoController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          _profile(controller.data.value, controller),
          _statusAbsen(),
          _content(controller.data.value)
        ]),
      ),
    );
  }

  Widget _statusAbsen() {
    return detailInfoController.data.value.isAbsen == true
        ? SizedBox(
            height: 20,
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 242, 242, 242),
                    padding: EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () async {
                  final hasPermission =
                      await detailInfoController.handleLocationPermission();
                  if (!hasPermission) return;

                  detailInfoController.birthdateFC.clear();
                  DialogHelper.showDateVerification(
                      title: 'Verifikasi Tanggal Lahir',
                      textController: detailInfoController.birthdateFC,
                      action: (dateSelected) {
                        detailInfoController.onValidationPresensi(dateSelected);
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Presensi',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                )),
          );
  }

  Widget _profile(Person data, DetailInfoController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Hero(
                transitionOnUserGestures: true,
                tag: "image" + data.id.toString(),
                child: circleAvatar(
                    imageData: "", nameData: data.name ?? '', size: 45)),
          ),
          SizedBox(height: 10),
          Center(
            child: Hero(
              tag: "name" + data.id.toString(),
              flightShuttleBuilder: _flightShuttleBuilder,
              transitionOnUserGestures: true,
              child: Text(
                data.name ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: "jail" + data.id.toString(),
              flightShuttleBuilder: _flightShuttleBuilder,
              transitionOnUserGestures: true,
              child: Text(
                data.jail!.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    color: Colors.grey.shade400,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _content(Person data) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _listStatusPresensi(),
                  SizedBox(height: 15),
                  _listInfo("Kasus", data.personCase.toString(), delay: 1),
                  SizedBox(height: 15),
                  _listInfo("Petugas", data.pk!.name.toString(), delay: 2),
                  SizedBox(height: 15),
                  _listInfo("Tipe", data.type!.name.toString(), delay: 3),
                  SizedBox(height: 15),
                  _listInfo(
                      "Tanggal Disposisi", data.dateDisposition.toString(),
                      delay: 4),
                  SizedBox(height: 15),
                  _listInfo("Nomor TPP", data.numberTpp.toString(), delay: 5),
                  SizedBox(height: 15),
                  (!(['diproses', ''])
                          .contains(data.status.toString().toLowerCase()))
                      ? _listInfo("Tanggal TPP", data.dateTpp.toString(),
                          delay: 6)
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(height: 15),
                  (!(['diproses', 'diterima'])
                          .contains(data.status.toString().toLowerCase()))
                      ? _listInfo("Tanggal Terkirim", data.dateSend.toString(),
                          delay: 7)
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(height: 15),
                  (!(['diproses', 'terima', 'kirim'])
                          .contains(data.status.toString().toLowerCase()))
                      ? _listInfo(
                          "Tanggal Bimbingan", data.dateStart.toString(),
                          status: true,
                          endDate: data.dateEnd.toString(),
                          delay: 8)
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(height: 15),
                  _listInfo("Status", data.status.toString(), delay: 9),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listStatusPresensi() {
    return FadeInLeft(
      delay: Duration(milliseconds: 100),
      duration: Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status Presensi",
            style: GoogleFonts.poppins(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: detailInfoController.data.value.isAbsen == true
                  ? Colors.green.withOpacity(1)
                  : Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                      detailInfoController.data.value.isAbsen == true
                          ? FontAwesome.check_circle
                          : FontAwesome.minus_circle,
                      color: Colors.white,
                      size: 18),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    detailInfoController.data.value.isAbsen == true
                        ? "Sudah melakukan presensi"
                        : "Belum melakukan presensi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listInfo(String header, String data,
      {bool status = false, String? endDate, required int delay}) {
    return FadeInLeft(
      delay: Duration(milliseconds: 100 * delay),
      duration: Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: GoogleFonts.poppins(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          (status)
              ? Row(
                  children: [
                    Text(
                      data,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(" - "),
                    Text(
                      endDate!,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : Text(
                  data,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
        ],
      ),
    );
  }
}

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: GoogleFonts.poppins(
        decoration: TextDecoration.none,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    child: toHeroContext.widget,
  );
}
