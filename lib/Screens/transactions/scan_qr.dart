import 'package:flutter/material.dart';
import '../../const/app_strings.dart';
import '../../util/uiutil.dart';

class ScanQRCode extends StatelessWidget {
  final String? qrString;
  const ScanQRCode({super.key, this.qrString});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: normalAppBar(context, title: AppStrings.qrPayment),
          backgroundColor: Colors.indigo.shade50,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight(context) * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.60,
                    child: headerText(AppStrings.scanQrCodeForNextStep,
                        color: Colors.blueGrey.shade300,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
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
              )
            ],
          )),
    );
  }
}
