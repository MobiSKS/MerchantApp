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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight(context) * 0.06),
          customContainer(context,
              url: AppStrings.forPetrolDieselCS,
              title: AppStrings.forPetrolDieselQueries),
          SizedBox(height: screenHeight(context) * 0.02),
          customContainer(context,
              url: AppStrings.forHPgasORLPGQCS,
              title: AppStrings.forHpGasQueries),
          SizedBox(height: screenHeight(context) * 0.02),
          customContainer(context, url: UrlConstant.hpPayLink, isUrl: true),
          SizedBox(height: screenHeight(context) * 0.02),
        ],
      ),
    );
  }

  Widget customContainer(BuildContext context,  
      {bool isUrl = false, String url = '', String title = ""}) {
    return GestureDetector(
      onTap: () {
        isUrl ? urlLauncher.launch(url) : urlLauncher.launch('tel://$url');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: screenHeight(context) * 0.075,
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    isUrl ? ImageResources.webIcon : ImageResources.callIcon,
                    height: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  semiBoldText(
                    url,
                    color: Colors.indigo,
                  )
                ]),
            SizedBox(
              width: screenWidth(context) * 0.30,
              child: semiBoldText(title,
                  color: Colors.indigo,
                  textAlign: TextAlign.center,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
