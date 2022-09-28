import 'package:dtplusmerchant/model/user_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../common/custom_list.dart';
import '../common/download_widget.dart';
import '../common/separator.dart';
import '../common/share_widget.dart';
import '../const/image_resources.dart';
import '../model/receipt_detal.dart';
import 'utils.dart';





Widget underlinedText(String text,
    {Color color = Colors.black, double fontSize = 14.0}) {
  return Text(text,
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: color,
          fontSize: fontSize,
          fontFamily: FontFamilyHelper.sourceSansRegular));
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
        child: boldText(text!, fontSize: 20),
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
      return boldText('${time.toInt().toString()}: 00',
          color: color, fontSize: 13.0);
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
    color: Colors.blue.shade100,
    child: Center(child: boldText(text, color: Colors.black, fontSize: 22)),
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

alertPopUp(BuildContext context, String message, {bool doLogout = false}) {
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
                    boldText(message,
                        fontSize: 18,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    customButton(context, 'OK', onTap: () {
                      doLogout ? Utils.logout(context) : Navigator.pop(context);
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
    title: boldText(
      title,
      color: Colors.black,
      fontSize: 24,
    ),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.grey, size: 26))
    ],
  );
}

Widget receiptHeader(BuildContext context,
    {String? copyType, ObjGetMerchantDetail? custDetail, String? outletName}) {
  return Column(
    children: [
      SizedBox(height: screenHeight(context) * 0.02),
      Image.asset(ImageResources.hpLogoReceipt, height: 100),
      SizedBox(height: screenHeight(context) * 0.015),
      boldText(copyType!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.004),
      boldText(custDetail!.header1!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.004),
      boldText(custDetail.header2!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.004),
      boldText(outletName!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.02),
    ],
  );
}

Widget receiptFooter(context, {ObjGetMerchantDetail? custDetail}) {
  return Column(
    children: [
      SizedBox(height: screenHeight(context) * 0.020),
      const Separator(
        color: Colors.blueGrey,
      ),
      SizedBox(height: screenHeight(context) * 0.020),
      normalText(custDetail!.footer1!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.01),
      normalText(custDetail.footer2!, color: Colors.black, fontSize: 20.0),
      SizedBox(height: screenHeight(context) * 0.020),
      const Separator(
        color: Colors.blueGrey,
      ),
      SizedBox(height: screenHeight(context) * 0.020),
    ],
  );
}

Widget receiptTitle(context, GlobalKey key) {
  return Container(
    width: screenWidth(context),
    height: screenHeight(context) * 0.06,
    color: Colors.blue.shade100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        boldText('Receipt', color: Colors.black),
        SizedBox(width: screenWidth(context) * 0.20),
        InkWell(
          child: CircleAvatar(
            backgroundColor: Colors.indigo.shade900,
            radius: 15,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(Icons.share_rounded,
                  size: 20, color: Colors.indigo.shade900),
            ),
          ),
          onTap: () {
            sharePng(context, key);
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .04,
        ),
        InkWell(
          child: CircleAvatar(
            backgroundColor: Colors.indigo.shade900,
            radius: 15,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(Icons.download_rounded,
                  size: 20, color: Colors.indigo.shade900),
            ),
          ),
          onTap: () {
            captureAndSharePng(context, key, pop: false);
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .06,
        ),
      ],
    ),
  );
}

Widget receiptDetail(
  BuildContext context,
  List<ReceiptDetail> receptDetail1,
) {
  return CustomList(
      list: receptDetail1,
      itemSpace: 7,
      child: (ReceiptDetail data, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText(
              data.title!,
              fontSize: 16.0,
            ),
            boldText(data.value!, fontSize: 16.0, color: Colors.blueGrey),
          ],
        );
      });
}

Widget boldText(String text,
    {Color color = Colors.white,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 18.0,
    String fontFamily = FontFamilyHelper.sourceSansBold}) {
  return Text(text,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily));
}

Widget semiBoldText(String text,
    {Color color = Colors.white,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 16.0,
    String fontFamily = FontFamilyHelper.sourceSansSemiBold}) {
  return Text(text,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily));
}

Widget normalText(String text,
    {Color color = Colors.white,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 14.0,
    String fontFamily = FontFamilyHelper.sourceSansRegular}) {
  return Text(text,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: 14, fontFamily: fontFamily));
}
