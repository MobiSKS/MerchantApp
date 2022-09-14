import 'package:flutter/material.dart';
import '../const/app_strings.dart';
import '../util/uiutil.dart';

class ScanQRCode extends StatelessWidget {
  const ScanQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                header(context),
                SizedBox(height: screenHeight(context) * 0.02),
                title(context, AppStrings.scanQRcode),
                SizedBox(height: screenHeight(context) * 0.20),
                generateQRImage(
                  context,
                  size: screenWidth(context) * 0.70,
                )
              ],
            ),
          )),
    );
  }
}
