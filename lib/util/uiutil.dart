import 'package:dtplusmerchant/Screens/auth/auth_view_model.dart';
import 'package:dtplusmerchant/model/user_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../common/custom_list.dart';
import '../common/download_widget.dart';
import '../common/separator.dart';
import '../common/share_widget.dart';
import '../const/image_resources.dart';
import '../model/receipt_detal.dart';

Widget underlinedText(String text,
    {Color color = Colors.black, double fontSize = 14.0}) {
  return Text(text,
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: color,
          fontSize: fontSize,
          fontFamily: FontFamilyHelper.sourceSansSemiBold));
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
            borderRadius: BorderRadius.circular(13.0),
          ),
          filled: true,
          hintStyle: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 16,
              fontFamily: FontFamilyHelper.sourceSansSemiBold),
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
    padding: const EdgeInsets.symmetric(horizontal: 00),
    child: SizedBox(
      width: screenWidth(context),
      child: TextButton(
        onPressed: () {
          onTap!();
        },
        style: buttonStyle,
        child: boldText(text!, fontSize: 22, color: Colors.white),
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
    height: screenHeight(context) * 0.08,
    color: Colors.blue.shade100,
    child: Center(child: semiBoldText(text, color: Colors.black, fontSize: 22)),
  );
}

Widget header(BuildContext context, {bool transheader = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  if (transheader) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/dashboard', (Route<dynamic> route) => false);
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.black, size: 28)),
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
  var prov = Provider.of<AuthViewModel>(context, listen: false);
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
                    semiBoldText(message,
                        fontSize: 18,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    customButton(context, 'OK', onTap: () async {
                      if (doLogout) {
                        await prov.logout(context);
                      } else {
                        Navigator.pop(context);
                      }
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

Widget emailTextField(
    BuildContext context, TextEditingController controller, String hintText,
    {bool prefixIcon = true, String valMessage = ""}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      controller: controller,
      validator: (val) {
        String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(val!)) {
          return 'Enter Valid email Id';
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
          hintStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontFamily: FontFamilyHelper.sourceSansSemiBold),
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
    {bool showIcon = false,
    Function? onTap,
    bool enabled = true,
    bool showLabel = true,
    String? valMsg,
    FocusNode? focusNode,
    Function? onClick}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      focusNode: focusNode,
      enabled: enabled,
      onTap: () {
        if (focusNode != null) {
          onClick!();
        }
      },
      validator: (val) {
        if (valMsg != null) {
          if (val!.isEmpty) {
            return valMsg;
          } else {
            return null;
          }
        }
        return null;
      },
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 10),
          suffixIcon: showIcon
              ? GestureDetector(
                  onTap: () {
                    onTap!();
                  },
                  child: const Icon(Icons.date_range),
                )
              : null,
          labelText: hintText,
          labelStyle: TextStyle(
              fontSize: focusNode != null
                  ? focusNode.hasFocus || controller.text.isNotEmpty
                      ? 23
                      : 18
                  : 18,
              color: focusNode != null
                  ? focusNode.hasFocus
                      ? Colors.grey.shade700
                      : Colors.grey.shade700
                  : Colors.grey.shade700,
              fontFamily: FontFamilyHelper.sourceSansSemiBold)),
    ),
  );
}

Widget dateTextField(
    BuildContext context, TextEditingController controller, String hintText,
    {bool showIcon = false,
    Function? onTap,
    bool enabled = true,
    bool showLabel = true,
    FocusNode? focusNode}) {
  return SizedBox(
    width: screenWidth(context),
    child: TextFormField(
      focusNode: focusNode,
      enabled: enabled,
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
      ),
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

normalAppBar(BuildContext context,
    {String title = '', bool showTitle = true, bool freezeScreen = false}) {
  return PreferredSize(
    preferredSize: showTitle
        ? Size.fromHeight(screenHeight(context) * 0.157)
        : Size.fromHeight(screenHeight(context) * 0.085),
    child: Column(
      children: [
        SizedBox(
          height: 70,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 13),
                GestureDetector(
                    onTap: () => freezeScreen ? () {} : Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 27,
                    )),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 23,
                ),
                Image.asset(ImageResources.driveTruckPlusImage,
                    height: screenHeight(context) * 0.032),
              ],
            ),
            centerTitle: true,
            actions: [
              Column(
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.notifications,
                          color: Colors.grey, size: 26)),
                ],
              ),
              const SizedBox(width: 20)
            ],
          ),
        ),
        showTitle
            ? Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.06,
                color: Colors.blue.shade100,
                child: Center(
                    child:
                        semiBoldText(title, color: Colors.black, fontSize: 22)),
              )
            : Container()
      ],
    ),
  );
}

Widget receiptHeader(BuildContext context,
    {String? copyType,
    ObjGetMerchantDetail? custDetail,
    String? outletName,
    String roc = ""}) {
  return Column(
    children: [
      SizedBox(height: screenHeight(context) * 0.02),
      Image.asset(ImageResources.hpLogoReceipt, height: 80),
      SizedBox(height: screenHeight(context) * 0.010),
      semiBoldText(Utils.checkNullValue(copyType!),
          color: Colors.black, fontSize: 18.0),
      SizedBox(height: screenHeight(context) * 0.003),
      semiBoldText(custDetail!.header1!, color: Colors.black, fontSize: 18.0),
      SizedBox(height: screenHeight(context) * 0.003),
      semiBoldText(custDetail.header2!, color: Colors.black, fontSize: 18.0),
      SizedBox(height: screenHeight(context) * 0.003),
      semiBoldText(outletName!, color: Colors.black, fontSize: 18.0),
      SizedBox(height: screenHeight(context) * 0.003),
      semiBoldText(roc, color: Colors.black, fontSize: 18.0),
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
      SizedBox(height: screenHeight(context) * 0.018),
      normalText(custDetail!.footer1!, color: Colors.black, fontSize: 17.0),
      SizedBox(height: screenHeight(context) * 0.01),
      normalText(custDetail.footer2!, color: Colors.black, fontSize: 17.0),
      SizedBox(height: screenHeight(context) * 0.018),
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
        semiBoldText('Receipt', color: Colors.black, fontSize: 22),
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

Widget receiptDetail(BuildContext context, List<ReceiptDetail> receptDetail1,
    {double itemSapce = 7.0}) {
  return CustomList(
      list: receptDetail1,
      itemSpace: itemSapce,
      child: (ReceiptDetail data, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            normalText(data.title!, fontSize: 16.0),
            normalText(data.value!, fontSize: 16.0, color: Colors.blueGrey),
          ],
        );
      });
}

Widget boldText(String text,
    {Color color = Colors.black,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 20.0,
    String fontFamily = FontFamilyHelper.sourceSansBold}) {
  return Text(text,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily));
}

Widget semiBoldText(String text,
    {Color color = Colors.black,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 18.0,
    String fontFamily = FontFamilyHelper.sourceSansSemiBold}) {
  return Text(text,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily));
}

Widget normalText(String text,
    {Color color = Colors.black,
    TextAlign textAlign = TextAlign.start,
    double fontSize = 18.0,
    String fontFamily = FontFamilyHelper.sourceSansRegular}) {
  return Text(text,
      textAlign: textAlign,
      style:
          TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily));
}

Widget shareButton(context, GlobalKey key) {
  return InkWell(
    child: CircleAvatar(
      backgroundColor: Colors.indigo.shade900,
      radius: 15,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child:
            Icon(Icons.share_rounded, size: 20, color: Colors.indigo.shade900),
      ),
    ),
    onTap: () {
      sharePng(context, key);
    },
  );
}

Widget downloadButton(BuildContext context, GlobalKey key) {
  return InkWell(
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
  );
}

Widget countTimer(CountdownTimerController controller) {
  return CountdownTimer(
    controller: controller,
    widgetBuilder: (context, time) {
      if (time == null) {
        return semiBoldText('00:00', fontSize: 20);
      }
      return time.sec! > 9
          ? semiBoldText('0${time.min ?? 0} : ${time.sec ?? 0}', fontSize: 20)
          : semiBoldText('0${time.min ?? 0} : 0${time.sec ?? 0}', fontSize: 20);
    },
    textStyle: TextStyle(
        fontSize: 21,
        color: Colors.grey.shade900,
        fontFamily: FontFamilyHelper.sourceSansSemiBold),
  );
}

Widget searchWidget(BuildContext context, TextEditingController? controller,
    {Function? onTap, String? hintText, Function? onChanged}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: screenWidth(context) * 0.80,
        height: screenHeight(context) * 0.06,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade500,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          onChanged: (val) {
            onChanged!();
          },
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 15),
              prefixIcon: Column(
                children: const [
                  SizedBox(height: 12),
                  Icon(
                    Icons.search,
                    size: 30,
                  ),
                ],
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontFamily: FontFamilyHelper.sourceSansRegular,
                  fontSize: 19)),
        ),
      ),
      GestureDetector(
        onTap: () {
          onTap!();
        },
        child: Image.asset(ImageResources.filterIcon, height: 30, width: 30),
      )
    ],
  );
}

showGif(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Container(
            color: Colors.white,
            height: screenHeight(context) * 35,
            child: Center(
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(primary: Colors.transparent)),
                    child: Image.asset(ImageResources.tickImage))),
          ));
}

logOutPopUp(BuildContext context) {
  var prov = Provider.of<AuthViewModel>(context, listen: false);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight(context) * 0.06),
                    semiBoldText('Do you want to logout?',
                        fontSize: 18,
                        color: Colors.black,
                        textAlign: TextAlign.center),
                    SizedBox(height: screenHeight(context) * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: customButton(context, 'No', onTap: () {
                            Navigator.pop(context);
                          }),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: customButton(context, 'Yes', onTap: () async {
                            await prov.logout(context);
                          }),
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Positioned(top: screenHeight(context) * 0.33, child: hpLogo(context)),
        ],
      );
    },
  );
}
