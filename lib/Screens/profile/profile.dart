import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:flutter/material.dart';
import '../../const/app_strings.dart';
import '../../util/uiutil.dart';
import 'business_detail.dart';
import 'merchant_profile.dart';
import 'other_detail.dart';
import 'retail_outlet_address.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          header(context),
          SizedBox(height: screenHeight(context) * 0.02),
          title(context, AppStrings.profile),
          SizedBox(height: screenHeight(context) * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _headerIcons(),
          ),
          SizedBox(height: screenHeight(context) * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: index == 0
                ? GestureDetector(
                    onHorizontalDragStart: (drag) {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Merchantprofile())
                : index == 1
                    ? GestureDetector(
                        onHorizontalDragStart: (drag) {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: RetailOutletAddress())
                    : index == 2
                        ? GestureDetector(
                            onHorizontalDragStart: (drag) {
                              setState(() {
                                index = 3;
                              });
                            },
                            child: BusinessDetail())
                        : index == 3
                            ? GestureDetector(
                                onHorizontalDragStart: (drag) {
                                  setState(() {
                                    index = 0;
                                  });
                                },
                                child: OtherDetail())
                            : Container(),
          ),
        ],
      )),
    );
  }

  Widget _headerIcons() {
    return SizedBox(
      height: screenHeight(context) * 0.15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: screenWidth(context) * 0.15, child: profile()),
          iconConnector(),
          SizedBox(width: screenWidth(context) * 0.16, child: address()),
          iconConnector(),
          SizedBox(
              width: screenWidth(context) * 0.15, child: officialDetails()),
          iconConnector(),
          SizedBox(width: screenWidth(context) * 0.17, child: otherDetails()),
        ],
      ),
    );
  }

  Widget profile() {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = 0;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor:
                  index == 0 ? Colors.indigo.shade900 : Colors.indigo.shade100,
              child: Image.asset(
                  index == 0
                      ? ImageResources.basicInfoWhite
                      : ImageResources.basicInfoBlue,
                  height: 21)),
          const SizedBox(height: 10),
          normalText(AppStrings.merchantprofile,   textAlign: TextAlign.center,fontSize:16 )
        ],
      ),
    );
  }

  Widget address() {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = 1;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor:
                  index == 1 ? Colors.indigo.shade900 : Colors.indigo.shade100,
              child: Image.asset(
                  index == 1
                      ? ImageResources.addressWhite
                      : ImageResources.addressBlue,
                  height: 21)),
          const SizedBox(height: 10),
          normalText(AppStrings.retailOutletAddress,   textAlign: TextAlign.center,fontSize:16
            )
        ],
      ),
    );
  }

  Widget officialDetails() {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = 2;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor:
                  index == 2 ? Colors.indigo.shade900 : Colors.indigo.shade100,
              child: Image.asset(
                  index == 2
                      ? ImageResources.officialDetailsWhite
                      : ImageResources.officialDetailsBlue,
                  height: 21)),
          const SizedBox(height: 10),
          normalText(AppStrings.keyOfficialDetail,   textAlign: TextAlign.center,fontSize: 16.0)
        ],
      ),
    );
  }

  Widget otherDetails() {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = 3;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor:
                  index == 3 ? Colors.indigo.shade900 : Colors.indigo.shade100,
              child: Image.asset(
                  index == 3
                      ? ImageResources.otherDetailsWhite
                      : ImageResources.otherDetailsBlue,
                      
                  height: 21)),
          const SizedBox(height: 10),
          normalText(
              index == 3
                  ? AppStrings.contactPersonDetail
                  : AppStrings.otherDetails,
                  textAlign: TextAlign.center,
              fontSize: 16.0)
        ],
      ),
    );
  }

  Widget iconConnector() {
    return Column(
      children: [
        const SizedBox(height: 20),
        horizontalDivider(context),
      ],
    );
  }
}
