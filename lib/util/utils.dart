// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import '../const/injection.dart';
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

  static String convertDateFormatInYYMMDD({DateTime? dateT, String? dateS}) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    if (dateS != null) {
      var dateTime = dateFormat.parse(dateS);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(dateT!);
    }
  }

  static String convertDateFormatInDDMMYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

//===========date format ======== exp: 2022-09-17 18:08:23============
  static String dateTimeFormat() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  static Future<void> selectDatePopup(BuildContext context,
      DateTime initialDate, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
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
      var formatedDate = convertDateFormatInDDMMYY(initialDate);
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

  static String getNameInitials(String? name) {
    var string = name!.split(" ");
    if (string.length > 1) {
      return string[0][0] + string[1][0];
    } else {
      return string[0][0];
    }
  }

  static Color getRamdomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  static textToSpeech(String text) async {
    FlutterTts ftts = FlutterTts();
    await ftts.setLanguage("hi-IN");
    await ftts.setSpeechRate(0.5); //speed of speech
    await ftts.setVolume(1.0); //volume of speech
    await ftts.setPitch(2.0);
    var voice = await ftts.getVoices; //pitc of sound
    await ftts.setVoice({"name": "hi-in-x-hia-local", "locale": "hi-IN"});
    int idx = text.indexOf(".");
    List parts = [
      text.substring(0, idx).trim(),
      text.substring(idx + 1).trim()
    ];
    if (parts[1][0] == "0") {
      await ftts
          .speak("Treansaction of amount  Rupees ${parts[0]} is successful. ");
    } else {
      await ftts.speak(
          "Treansaction of amount  Rupees ${parts[0]} and  ${int.parse(parts[1])} Paise is successful");
    }
  }

  static String checkNullValue(String? val) {
    if (val != null && val.isNotEmpty && val != "null") {
      return val;
    } else {
      return '-';
    }
  }
}
