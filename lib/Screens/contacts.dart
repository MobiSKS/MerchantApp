import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../const/app_strings.dart';
import '../const/image_resources.dart';

class Contacts extends StatelessWidget{
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Container(height: screenHeight(context) * 0.83, color: Colors.white),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight(context) * 0.06),
              headerText(AppStrings.forPetrolDieselQueries,
                  color: Colors.black, fontWeight: FontWeight.normal),
              SizedBox(height: screenHeight(context) * 0.02),
              _contactNumber(AppStrings.forPetrolDieselCS),
              SizedBox(height: screenHeight(context) * 0.02),
              const Divider(color: Colors.blueGrey),
              SizedBox(height: screenHeight(context) * 0.02),
              headerText(AppStrings.forHpGasQueries,
                  color: Colors.black, fontWeight: FontWeight.normal),
              SizedBox(height: screenHeight(context) * 0.02),
              _contactNumber(AppStrings.forHPgasORLPGQCS),
              SizedBox(height: screenHeight(context) * 0.02),
              const Divider(color: Colors.blueGrey),
              SizedBox(height: screenHeight(context) * 0.02),
              headerText(AppStrings.website,
                  color: Colors.black, fontWeight: FontWeight.normal),
              SizedBox(height: screenHeight(context) * 0.02),
              _contactNumber(AppStrings.hpPayLink, isURl: true),
              SizedBox(height: screenHeight(context) * 0.02),
            ],
          ),
        )
      ],
    );
  }

  Widget _contactNumber(String url, {bool isURl = false}) {
    return GestureDetector(
      onTap: () {
        isURl ? urlLauncher.launch(url) : urlLauncher.launch('tel://$url');
      },
      child: Row(
        children: [
          Image.asset(
            isURl ? ImageResources.webIcon : ImageResources.callIcon,
            height: 20,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          headerText(url, color: Colors.black, fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}
