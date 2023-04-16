// ignore_for_file: unused_local_variable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static Future<String> getChatTime(String? date) async {
    if (date == null || date.isEmpty) {
      return '';
    }
    String msg = '';
    var dt = date.contains("T")
        ? DateTime.parse(date).toLocal()
        : DateTime.parse(date);
    DateTime now = DateTime.now();

    if (now.isBefore(dt)) {
      return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
    }

    var dur = now.difference(dt);
    print(dur);
    if (dt.year != now.year) {
      return DateFormat("dd MMM yyyy", Get.locale!.countryCode).format(dt);
    } else if (dur.inDays > 0 && dur.inDays < 3) {
      msg = '${dur.inDays} h';
    } else if (dur.inDays >= 3) {
      return DateFormat("dd MMM", Get.locale!.countryCode).format(dt);
    } else if (dur.inDays < 0) {
      DateFormat("dd MMM YYYY", 'i h').format(dt);
    } else if (dur.inHours > 0) {
      msg = '${dur.inHours} j';
    } else if (dur.inMinutes > 0) {
      msg = '${dur.inMinutes} m';
    } else if (dur.inSeconds > 0) {
      msg = '${dur.inSeconds} d';
    } else {
      msg = 'now';
    }
    return msg;
  }

  static Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? initial,
    DateTime? start,
    DateTime? end,
  }) async {
    DateTime? picked = await showDatePicker(
        confirmText: 'OK',
        context: context,
        locale: Get.locale,
        initialDate: initial ?? DateTime.now(),
        firstDate: start ?? DateTime(1945),
        lastDate: end ?? DateTime(2100));
    return picked;
  }

  static Future<DateTime> getTimeNow() async {
    DateTime _myTime;
    DateTime _ntpTime = DateTime.now();
    try {
      print('ntp 1');

      /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)

      print('ntp 2');

      //  Or get NTP offset (in milliseconds) and add it yourself
      print('ntp 4');
    } catch (e) {
      return DateTime.now();
    }

    return _ntpTime;
  }

  static Future<DateTime?>? selectDateTime(BuildContext context,
      {DateTime? minDate, DateTime? currentDate}) async {
    DateTime? picked = await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: minDate ?? DateTime(1900, 1, 1), onChanged: (date) {
      return date;
    }, onConfirm: (date) {
      return date;
    }, currentTime: currentDate ?? DateTime.now(), locale: LocaleType.id);
    return picked;
  }
}
