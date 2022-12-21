// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:dtplusmerchant/Screens/transactions/qr_receipt.dart';
import 'package:dtplusmerchant/model/generate_qr_response.dart';
import 'package:dtplusmerchant/provider/transactions_provider.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../const/image_resources.dart';
import '../../util/uiutil.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ScanQRCode extends StatefulWidget {
  final String? qrString;
  final String? outletName;
  final String? amount;
  final String? transType;
  final GenerateQrResponse? qrResp;
  const ScanQRCode(
      {super.key,
      this.qrString,
      this.amount,
      this.outletName,
      this.qrResp,
      this.transType});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  var timerController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timerController = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 180,
        onEnd: navigateBack);
    timer = Timer.periodic(
        const Duration(seconds: 4), (Timer t) => checkQRstatus());
  }

  @override
  void dispose() {
    timer?.cancel();
    timerController.dispose();
    super.dispose();
  }

  Future<void> checkQRstatus() async {
    TransactionsProvider transPro =
        Provider.of<TransactionsProvider>(context, listen: false);
    await transPro.getQRStatus(context,
        qRId: widget.qrResp!.data!.first.requestId,
        transactionType: widget.transType);
    if (transPro.qrStatusModel != null &&
        transPro.qrStatusModel!.internelStatusCode == 1000) {
      showGif(context);
      Utils.textToSpeech(transPro.qrStatusModel!.data!.first.amount.toString());
      timer?.cancel();
      Future.delayed(const Duration(seconds: 3), () {
        dismissLoader(context);
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => QRReceipt(
              qrStatusResp: transPro.qrStatusModel,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        const shouldPop = false;
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: normalAppBar(context,
                title: AppStrings.qrPayment, freezeScreen: true),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight(context) * 0.02),
                  Image.asset(ImageResources.hpLogoReceipt, height: 100),
                  SizedBox(height: screenHeight(context) * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth(context) * 0.60,
                        child: semiBoldText(AppStrings.scanQrCodeForNextStep,
                            color: Colors.blueGrey.shade300,
                            fontSize: 21,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.04),
                  Container(
                    width: screenWidth(context) * 0.65,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey.shade300)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: generateQRImage(
                          context,
                          data: widget.qrString!,
                          size: screenWidth(context) * 0.60,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.04),
                  semiBoldText('Amount:  ₹ ${widget.amount}0', fontSize: 24),
                  SizedBox(height: screenHeight(context) * 0.01),
                  semiBoldText(widget.outletName!, fontSize: 24),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      semiBoldText('Valid Till ', fontSize: 23),
                      const SizedBox(width: 10),
                      CountdownTimer(
                        controller: timerController,
                        widgetBuilder: (context, time) {
                          if (time == null) {
                            return boldText('QR Expired');
                          }

                          return time.sec! > 9
                              ? semiBoldText(
                                  '0${time.min ?? 0} : ${time.sec ?? 0}',
                                  fontSize: 23)
                              : semiBoldText(
                                  '0${time.min ?? 0} : 0${time.sec ?? 0}',
                                  fontSize: 23);
                        },
                        textStyle: TextStyle(
                            fontSize: 21,
                            color: Colors.grey.shade900,
                            fontFamily: FontFamilyHelper.sourceSansSemiBold),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  navigateBack() {
    Navigator.pop(context);
  }
}
