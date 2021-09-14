import 'dart:async';
import 'package:si_bima/controllers/base/service_controller.dart';
import 'package:si_bima/controllers/home/home_controller.dart';
import 'package:si_bima/models/person.dart';
import 'package:get/get.dart';

class DetailInfoController extends GetxController with ServiceController {
  final HomeController homeController = Get.find();
  Person data = Get.arguments;
  String jail = '';
  final animate = false.obs;

  @override
  void onInit() async {
    _onAnimatedWidget();
    super.onInit();
  }

  _onAnimatedWidget(){
    Timer(Duration(milliseconds: 100), () {
      animate.value = true;
});
  }
}
