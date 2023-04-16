// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:si_bima/controllers/base/service_controller.dart';
import 'package:si_bima/models/type.dart';
import 'package:si_bima/services/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController with ServiceController {
  final _isLoading = true.obs;

  final searchResult = [].obs;
  final typesData = [].obs;
  late final searchText = ''.obs;
  late final typeText = ''.obs;
  final typeData = <Type>[];
  List types = [];

  final searchFC = TextEditingController();
  final jailFC = TextEditingController();

  @override
  void onInit() async {
    _timerGetTypes();
    ever(searchText, (_) => _isLoading.value = true);
    debounce(searchText, (_) => {onGetPerson()},
        time: Duration(milliseconds: 900));
    super.onInit();
  }

  _timerGetTypes() {
    Timer(Duration(milliseconds: 4000), () {
      onGetTypes();
    });
  }

  onGetTypes() async {
    print("get 1");
    try {
      var response =
          await ServiceProvider.getData('/type').catchError(handleError);

      if (response == null) return;

      if (response['success']) {
        types.clear();
        typesData.assignAll(response['data']);

        final _jail = List<Type>.from(
            (response['data']).map((item) => Type.fromJson(item)).toList());
        _jail.sort((a, b) => a.name.compareTo(b.name));
        typeData.assignAll(_jail);
        update();
      }
      for (int i = 0; i < typesData.length; i++) {
        types.add(typesData[i]['name']);
      }
    } finally {}
  }

  onGetPerson() async {
    print('get 2');
    if (searchFC.text != '') {
      _isLoading.value = true;
      try {
        var response = typeText.value != ''
            ? await ServiceProvider.getData(
                    '?type=' + typeText.value + '&name=' + searchFC.text)
                .catchError(handleError)
            : await ServiceProvider.getData('?type=&name=' + searchFC.text)
                .catchError(handleError);

        if (response == null) return;

        if (response['success']) {
          print("object");
          searchResult.assignAll(response['data']);
          _isLoading.value = false;
        }
        print(searchResult.length);
      } finally {
        _isLoading.value = false;
      }
    } else {
      _isLoading.value = false;
      searchResult.clear();
    }
  }

  onUpdateType() async {
    if (typeData.length <= 0) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          onGetTypes();
        }
      } on SocketException catch (_) {
        print('not connected');
      }
    }
  }

  Future<void> onLaunchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  get isLoading => this._isLoading.value;
}
