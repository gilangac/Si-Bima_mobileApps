import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

Widget dialogInfo() {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Bapas Kelas II Madiun',
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          _separator(),
          _listaddress("web_vector.svg", "bapasmadiun.kemenkumham.go.id/",
              url: "https://bapasmadiun.kemenkumham.go.id/"),
          _listaddress("ig_vector.svg", "@bapasmadiun",
              url: "https://www.instagram.com/bapasmadiun/"),
          _listaddress("twitter_vector.svg", "@MadiunBapas",
              url: "https://www.twitter.com/madiunbapas/"),
          _listaddress("location_vector.svg", "Jl. Salak No.85 Kota Madiun",
              url:
                  "https://www.google.com/maps/search/?api=1&query=bapas%20madiun"),
          _listaddress("mail_vector.svg", "info@bapasmadiun.com",
              url: "mailto:info@bapasmadiun.com"),
          // _listaddress("wa_vector.svg", "-", url: 'https://wa.me/+62-?text='),
          _separator(),
          Row(
            children: [
              Text("Versi Aplikasi",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              Spacer(),
              Text("1.2")
            ],
          )
        ],
      ),
    ),
  );
}

Widget _separator() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Container(width: Get.width, height: 2, color: Colors.grey[200]),
  );
}

Widget _listaddress(String svg, String address, {String? url}) {
  HomeController controller = Get.find();
  return GestureDetector(
    onTap: () => controller.onLaunchUrl(url!),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            child: SvgPicture.asset("assets/svg/" + svg),
            width: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(address,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w400)),
          )
        ],
      ),
    ),
  );
}
