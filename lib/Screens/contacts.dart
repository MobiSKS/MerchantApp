// ignore_for_file: deprecated_member_use, library_prefixes
import 'package:dtplusmerchant/const/url_constant.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../const/app_strings.dart';
import '../const/image_resources.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(child: _body(context)),
    );
  }


  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight(context) * 0.06),
          normalText(AppStrings.forPetrolDieselQueries,
              color: Colors.black),
          SizedBox(height: screenHeight(context) * 0.02),
          _contactNumber(AppStrings.forPetrolDieselCS),
          SizedBox(height: screenHeight(context) * 0.02),
          const Divider(color: Colors.blueGrey),
          SizedBox(height: screenHeight(context) * 0.02),
          normalText(AppStrings.forHpGasQueries, color: Colors.black),
          SizedBox(height: screenHeight(context) * 0.02),
          _contactNumber(AppStrings.forHPgasORLPGQCS),
          SizedBox(height: screenHeight(context) * 0.02),
          const Divider(color: Colors.blueGrey),
          SizedBox(height: screenHeight(context) * 0.02),
          normalText(AppStrings.website, color: Colors.black),
          SizedBox(height: screenHeight(context) * 0.02),
          _contactNumber(UrlConstant.hpPayLink, isURl: true),
          SizedBox(height: screenHeight(context) * 0.02),
        ],
      ),
    );
  }

  Widget _contactNumber(String url, {bool isURl = false}) {
    return GestureDetector(
      onTap: () {
        isURl ? urlLauncher.launch(url) : urlLauncher.launch('tel://$url');
      },
      child: Row(children: [
        Image.asset(
          isURl ? ImageResources.webIcon : ImageResources.callIcon,
          height: 20,
          color: Colors.black,
        ),
        const SizedBox(width: 10),
        boldText(
          url,
          color: Colors.black,
        )
      ]),
    );
  }
}
