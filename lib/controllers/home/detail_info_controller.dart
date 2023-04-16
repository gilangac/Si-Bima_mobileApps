// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:si_bima/controllers/base/service_controller.dart';
import 'package:si_bima/controllers/home/home_controller.dart';
import 'package:si_bima/helpers/dialog_helper.dart';
import 'package:si_bima/helpers/snackbar_helper.dart';
import 'package:si_bima/models/person.dart';
import 'package:get/get.dart';
import 'package:si_bima/routes/pages.dart';
import 'package:si_bima/services/service_provider.dart';

class DetailInfoController extends GetxController with ServiceController {
  final HomeController homeController = Get.find();
  var data = Person().obs;
  final animate = false.obs;
  final birthdateFC = TextEditingController();

  String jail = '';
  Position? _currentPosition;
  File? fileResult;
  var presensiLocation = ''.obs;
  var selectedImagePath = ''.obs;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      data.value = Get.arguments;
    }
    _onAnimatedWidget();
    super.onInit();
  }

  _onAnimatedWidget() {
    Timer(Duration(milliseconds: 200), () {
      animate.value = true;
    });
  }

  onValidationPresensi(String birthDate) async {
    try {
      DialogHelper.showLoading();
      var body = {
        "number_tpp": data.value.numberTpp,
        "birthday": birthDate,
      };
      var response = await ServiceProvider.postData('/login', data: body)
          .catchError(handleError);

      if (response == null) return;

      if (response['success']) {
        await getCurrentPosition();
        Get.back();
        Get.toNamed(AppPages.PRESENSI);
      } else {
        Get.back();
        SnackBarHelper.showError(
            description:
                "Tanggal lahir tidak sesuai. Masukkan tanggal lahir yang benar.");
      }
    } finally {}
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SnackBarHelper.showError(
          description:
              'Perizinan akses lokasi perlu diaktifkan untuk fitur presensi');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SnackBarHelper.showError(
            description:
                'Perizinan akses lokasi perlu diaktifkan untuk fitur presensi');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      SnackBarHelper.showError(
          description:
              'Perizinan akses lokasi perlu diaktifkan untuk fitur presensi');

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      presensiLocation.value =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  getImage() async {
    final ImagePicker _picker = ImagePicker();

    await _picker
        .pickImage(
      preferredCameraDevice: CameraDevice.front,
      source: ImageSource.camera,
      imageQuality: 20,
    )
        .then((XFile? fileRaw) async {
      File file = File(fileRaw!.path);

      if (file == null) {
        return;
      } else {
        selectedImagePath.value = file.path;
        fileResult = file;
      }
    }).onError((error, stackTrace) {
      print('Belum ada foto yang diambil');
    });
  }

  onSendPresensi() async {
    if (presensiLocation.value != '' && selectedImagePath.value != '') {
      try {
        DialogHelper.showLoading();
        var formData = dio.FormData.fromMap({
          'id': data.value.id,
          'lat': _currentPosition?.latitude ?? '',
          "long": _currentPosition?.longitude ?? '',
          "image": await dio.MultipartFile.fromFile(selectedImagePath.value)
        });

        var response =
            await ServiceProvider.postDataFile('/absen', data: formData)
                .catchError(handleError);

        if (response['success']) {
          data.value.isAbsen = true;
          data.refresh();
          update();
          refresh();
          HomeController homeC = Get.find();
          homeC.searchResult.forEach((element) {
            if (element['id'].toString() == data.value.id.toString()) {
              element['isAbsen'] = true;
            }
          });
          Get.back();
          Get.back();
          SnackBarHelper.showSucces(
              description: "Berhasil melakukan presensi.");
        } else {
          Get.back();
          Get.back();
          SnackBarHelper.showError(
              description: "Terjadi kesalahan. Coba lagi nanti.");
        }
      } finally {}
    } else {
      if (presensiLocation.value == '') {
        getCurrentPosition();
      } else {
        SnackBarHelper.showError(description: "Ambil foto terlebih dahulu!");
      }
    }
  }
}
