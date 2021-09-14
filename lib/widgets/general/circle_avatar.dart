import 'package:si_bima/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget circleAvatar(
    {required String? imageData,
    required String nameData,
    required double size}) {
  return CircleAvatar(
    radius: size,
    backgroundColor: (['', null].contains(imageData))
        ? AppColors.yellow
        : Colors.grey.shade300,
    backgroundImage: NetworkImage(imageData.toString()),
    onBackgroundImageError: (exception, stackTrace) => Text(
        nameData[0].toUpperCase(),
        style: GoogleFonts.poppins(
            fontSize: size / 1.1,
            color: Colors.white,
            fontWeight: FontWeight.w500)),
    child: (['', null].contains(imageData))
        ? Text(nameData[0].toUpperCase(),
            style: GoogleFonts.poppins(
                fontSize: size / 1.1,
                color: Colors.black,
                fontWeight: FontWeight.w500))
        : Container(),
  );
}
