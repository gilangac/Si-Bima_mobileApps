// ignore_for_file: unused_field

import 'dart:developer';

import 'package:si_bima/helpers/dialog_helper.dart';
import 'package:si_bima/services/service_exception.dart';
import 'package:get/get.dart';

class ServiceController {
  void handleError(error) {
    if (error is BadRequestException) {
      Get.back();

      var message = error.message;
      var url = error.url;
      log('error $message', name: 'STATUS ERROR');

      if (url == '/jail') {
        print(message);
      } else {}
    } else if (error is ApiNotRespondingException) {
      var message = error.message;
      print(message);
    } else if (error is UnauthorizedException) {
      var message = error.message;
      print(message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showError(description: message);
    }
  }

  static final _errorMessages = {
    '/jail': {
      'title': 'Gagal',
      'description':
          'Waduh sepertinya ada masalah saat melakukan load Asal Permintaan. Pastikan koneksi anda stabil dan silahkan coba lagi.',
    },
  };
}
