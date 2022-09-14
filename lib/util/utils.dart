import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import '../const/injection.dart';
import '../preferences/shared_preference.dart';

class Utils {
  static final SharedPref _sharedPref = Injection.injector.get<SharedPref>();

  static void logout(BuildContext context) {
    _sharedPref.preferenceClear();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }

  static Future<String?> getDeviceToken() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
  }

  static String convertDateFormatInYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static Future<void> selectDatePopup(
    BuildContext context,
    DateTime initialDate,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.indigo.shade400,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      initialDate = picked;
      var formatedDate = convertDateFormatInYYMMDD(initialDate);

      controller.text = formatedDate;
    }
  }
}
