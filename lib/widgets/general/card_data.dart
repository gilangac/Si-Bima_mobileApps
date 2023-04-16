// ignore_for_file: must_be_immutable

import 'package:si_bima/models/person.dart';
import 'package:si_bima/routes/pages.dart';
import 'package:si_bima/widgets/general/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class DataCard extends StatelessWidget {
  Person data;
  bool? isViewOnly;
  DataCard({Key? key, required this.data, this.isViewOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isViewOnly!) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          Get.toNamed(AppPages.DETAIL_INFO, arguments: data);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 4,
                      spreadRadius: 5)
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleAvatar(),
                  SizedBox(width: 12),
                  _content(),
                ],
              ),
            ),
            isViewOnly!
                ? SizedBox()
                : Positioned(
                    bottom: 10,
                    right: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Text(
                        'Detail...',
                        style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _circleAvatar() {
    return Hero(
        transitionOnUserGestures: true,
        tag: "image" + data.id.toString(),
        child: circleAvatar(imageData: "", nameData: data.name ?? '', size: 30));
  }

  Widget _content() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: "name" + data.id.toString(),
            transitionOnUserGestures: true,
            child: Text(data.name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Hero(
            tag: "jail" + data.id.toString(),
            transitionOnUserGestures: true,
            child: Text(data.jail!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}
