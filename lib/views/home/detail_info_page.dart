import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/controllers/home/detail_info_controller.dart';
import 'package:si_bima/models/person.dart';
import 'package:si_bima/widgets/general/circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailInfoScreen extends StatelessWidget {
  const DetailInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailInfoController = Get.put(DetailInfoController());

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: SafeArea(
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
      ),
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
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        _profile(controller.data, controller),
        _content(controller.data)
      ]),
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
                child:
                    circleAvatar(imageData: "", nameData: data.name, size: 45)),
          ),
          SizedBox(height: 10),
          Center(
            child: Hero(
              tag: "name" + data.id.toString(),
              flightShuttleBuilder: _flightShuttleBuilder,
              transitionOnUserGestures: true,
              child: Text(
                data.name,
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
                data.jail.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    color: Colors.grey.shade400,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _content(Person data) {
    DetailInfoController controller = Get.find();
    return Expanded(
      child: Container(
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
              Expanded(
                  child: Obx(() => Stack(
                        children: [
                          AnimatedPositioned(
                            left: controller.animate.value ? 0 : -300,
                            duration: Duration(milliseconds: 500),
                            child: SingleChildScrollView(
                              child: Container(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _listInfo(
                                        "Kasus", data.personCase.toString()),
                                    SizedBox(height: 15),
                                    _listInfo(
                                        "Petugas", data.pk.name.toString()),
                                    SizedBox(height: 15),
                                    _listInfo(
                                        "Tipe", data.type.name.toString()),
                                    SizedBox(height: 15),
                                    _listInfo("Tanggal Disposisi",
                                        data.dateDisposition.toString()),
                                    SizedBox(height: 15),
                                    _listInfo(
                                        "Nomor TPP", data.numberTpp.toString()),
                                    SizedBox(height: 15),
                                    (!(['diproses', '']).contains(data.status
                                            .toString()
                                            .toLowerCase()))
                                        ? _listInfo("Tanggal TPP",
                                            data.dateTpp.toString())
                                        : SizedBox(
                                            height: 0,
                                          ),
                                    SizedBox(height: 15),
                                    (!(['diproses', 'diterima']).contains(data
                                            .status
                                            .toString()
                                            .toLowerCase()))
                                        ? _listInfo("Tanggal Terkirim",
                                            data.dateSend.toString())
                                        : SizedBox(
                                            height: 0,
                                          ),
                                    SizedBox(height: 15),
                                    (!(['diproses', 'terima', 'kirim'])
                                            .contains(data.status
                                                .toString()
                                                .toLowerCase()))
                                        ? _listInfo("Tanggal Bimbingan",
                                            data.dateStart.toString(),
                                            status: true,
                                            endDate: data.dateEnd.toString())
                                        : SizedBox(
                                            height: 0,
                                          ),
                                    SizedBox(height: 15),
                                    _listInfo("Status", data.status.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _listInfo(String header, String data,
      {bool status = false, String? endDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: GoogleFonts.poppins(
              color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.w400),
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
