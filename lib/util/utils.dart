// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../const/injection.dart';
import '../model/user_model.dart';
import '../preferences/shared_preference.dart';

class Utils {
 
  static final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  static String merchantId =
      _sharedPref.user!.data!.objGetMerchantDetail![0].merchantId!;
  static String terminalId =
      _sharedPref.user!.data!.objGetMerchantDetail![0].terminalId!;
  static String outletName =
      _sharedPref.user!.data!.objOutletDetails![0].retailOutletName!;
  static String userToken =
      'Bearer ${_sharedPref.user!.data!.objGetMerchantDetail![0].token!}';

  static const int otpTypeForSale = 1;
  static const int otpTypeForCreditSaleComplete = 9;
   static const int otpTypeForCardBalanceEnquiry = 7;

  
//=======date format ===== exp: 2022-09-16================

  static String convertDateFormatInYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

//===========date format ======== exp: 2022-09-17 18:08:23============
  static String dateTimeFormat() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
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
      firstDate: DateTime(2022),
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

  static String? checkOs() {
    String? os;
    if (Platform.isAndroid) {
      os = "Android";
    } else if (Platform.isIOS) {
      os = "IOS";
    } else if (Platform.isWindows) {
      os = "Windows";
    }
    return os;
  }

//=======Date Format exp:  yyyy-MM-dd'T'HH:mm:ss.SSSZ========
  static String isoDateTimeFormat() {
    return "${DateTime.now().toIso8601String()}Z";
  }

  static Future<String> getIp() async {
    return await Ipify.ipv4();
  }
}
