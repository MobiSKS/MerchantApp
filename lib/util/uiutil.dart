import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../const/image_resources.dart';
import 'utils.dart';

Widget headerText(String text,
    {FontWeight fontWeight = FontWeight.w300,
    Color color = Colors.white,
    double fontSize = 18.0,
    TextAlign textAlign = TextAlign.start}) {
  return Text(text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight));
}

Widget smallText(String text,
    {dynamic size = 12.0,
    Color color = Colors.black,
    TextAlign align = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold}) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight));
}

Widget underlinedText(String text,
    {Color color = Colors.black, double fontSize = 12.0}) {
  return Text(text,
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: color,
          fontSize: fontSize,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold));
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget backgroundImage(BuildContext context) {
  return Image.asset(
    ImageResources.backgroundImage,
    width: screenWidth(context),
    fit: BoxFit.cover,
  );
}

Widget hpLogo(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(ImageResources.hpLogo, height: screenHeight(context) * 0.09),
    ],
  );
}

Widget driverTruckTextImage(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(ImageResources.driveTruckPlusImage,
          height: screenHeight(context) * 0.04),
    ],
  );
}

Widget otpTextField(BuildContext context, OtpFieldController controller,
    {Color color = Colors.white, Function? onComplete}) {
  return OTPTextField(
    controller: controller,
    length: 6,
    width: screenWidth(context),
    fieldWidth: 50,
    style: TextStyle(fontSize: 18, color: color),
    textFieldAlignment: MainAxisAlignment.spaceBetween,
    fieldStyle: FieldStyle.underline,
    keyboardType: TextInputType.number,
    otpFieldStyle: OtpFieldStyle(
        enabledBorderColor: color, disabledBorderColor: color //(here)
        ),
    onCompleted: (pin) {},
  );
}

Widget customTextField(
    BuildContext context, TextEditingController controller, String hintText,
    {bool prefixIcon = true, String valMessage = ""}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      controller: controller,
      validator: (val) => val!.isEmpty ? valMessage : null,
      decoration: InputDecoration(
          prefixIcon: prefixIcon ? const Icon(Icons.person, size: 20) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
          hintText: hintText,
          fillColor: Colors.white),
    ),
  );
}

var buttonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.red))));

Widget customButton(BuildContext context, String? text, {Function? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: SizedBox(
      width: screenWidth(context),
      height: screenHeight(context) * 0.05,
      child: TextButton(
        onPressed: () {
          onTap!();
        },
        style: buttonStyle,
        child: Text(
          text!,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget countDownTimer(BuildContext context, int seconds, controller,
    {Color color = Colors.white}) {
  return Countdown(
    seconds: seconds,
    controller: controller,
    build: (context, double time) {
      return smallText('${time.toInt().toString()}: 00',
          color: color, size: 13.0);
    },
    interval: const Duration(seconds: 1),
    onFinished: () {},
  );
}

Widget generateQRImage(BuildContext context,
    {String data = "DT plus app", double size = 200.0}) {
  return QrImage(
    data: data,
    version: QrVersions.auto,
    size: size,
    padding: const EdgeInsets.all(10),
  );
}

Widget title(context, String text) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context) * 0.06,
    color: Colors.indigo.shade300,
    child: Center(
        child:
            headerText(text, fontWeight: FontWeight.w500, color: Colors.black)),
  );
}

Widget header(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.black, size: 24)),
            SizedBox(width: screenWidth(context) * 0.06),
            Image.asset(ImageResources.driveTruckPlusImage,
                height: screenHeight(context) * 0.032),
          ],
        ),
        Row(
          children: [
            Image.asset(ImageResources.hpLogo,
                height: screenHeight(context) * 0.05),
          ],
        )
      ],
    ),
  );
}

showToast(String message, bool isError) {
  Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      fontSize: 14,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.indigo.shade900,
      timeInSecForIosWeb: 1);
}

dismissLoader(BuildContext context) {
  Navigator.pop(context);
}



alertPopUp(BuildContext context, String message,{bool doLogout =false}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: SizedBox(
                width: screenWidth(context),
                height: screenHeight(context) * 0.19,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 25),
                    headerText(message, fontSize: 18, color: Colors.black,textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    customButton(context, 'OK', onTap: () {
                    doLogout? Utils.logout(context):
                      Navigator.pop(context);
                    })
                  ],
                )),
          ),
          Positioned(top: screenHeight(context) * 0.33, child: hpLogo(context)),
        ],
      );
    },
  );
}

Widget mobileTextField(
    BuildContext context, TextEditingController controller, String hintText,
    {bool prefixIcon = true, String valMessage = ""}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (val) {
        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(val!)) {
          return 'Enter Valid Phone Number';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          prefixIcon: prefixIcon ? const Icon(Icons.person, size: 20) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
          hintText: hintText,
          fillColor: Colors.white),
    ),
  );
}

Widget horizontalDivider(BuildContext context) {
  return Container(
    height: 1,
    width: screenWidth(context) * 0.10,
    color: Colors.indigo.shade300,
  );
}

Widget simpleTextField(
    BuildContext context, TextEditingController controller, String hintText,
    {bool showIcon = false, Function? onTap}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixIcon: showIcon
              ? GestureDetector(
                  onTap: () {
                    onTap!();
                  },
                  child: const Icon(Icons.date_range),
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}

showLoader(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SizedBox(
            height: screenHeight(context) * 35,
            child: Center(
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(primary: Colors.transparent)),
                    child: CircularProgressIndicator(
                      color: Colors.indigo.shade700,
                    ))),
          ));
}

AppBar normalAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new,
            color: Colors.black, size: 24)),
    title: headerText(title,
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.grey, size: 26))
    ],
  );
}
