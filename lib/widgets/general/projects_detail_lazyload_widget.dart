import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PersonLazyLoadWidget extends StatelessWidget {
  PersonLazyLoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 6,
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100, blurRadius: 4, spreadRadius: 5)
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _projectImage(),
              SizedBox(width: 12),
              _content(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectImage() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.grey.shade300,
      ),
      child: Center(),
    );
  }

  Widget _content() {
    return Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
              ),
              height: 16,
              width: Get.width * 0.5),
          SizedBox(height: 8),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
              ),
              height: 14,
              width: Get.width * 0.25),
        ]));
  }
}
