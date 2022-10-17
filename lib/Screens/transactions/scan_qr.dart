import 'package:flutter/material.dart';
import '../../const/app_strings.dart';
import '../../const/image_resources.dart';
import '../../util/uiutil.dart';

class ScanQRCode extends StatelessWidget {
  final String? qrString;
  final String? outletName;
  final String? amount;
  const ScanQRCode({super.key, this.qrString, this.amount, this.outletName});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: normalAppBar(context),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(context,AppStrings.qrPayment),
              SizedBox(height: screenHeight(context) * 0.07),
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
                      data: qrString!,
                      size: screenWidth(context) * 0.60,
                    ),
                  ),
                ),
              ),
                 SizedBox(height: screenHeight(context) * 0.04),
                 boldText('Amount:  ₹ $amount',fontSize: 24),
                  SizedBox(height: screenHeight(context) * 0.01),
                 boldText(outletName!,fontSize: 24),
            ],
          )),
    );
  }
}
