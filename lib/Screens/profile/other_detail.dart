import 'package:flutter/material.dart';

import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';
import 'merchant_profile.dart';

class OtherDetail extends StatelessWidget {
  OtherDetail({super.key});
  final _sharedPref = Injection.injector.get<SharedPref>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(AppStrings.contactPersonDetail,
            color: Colors.black),
        const SizedBox(height: 20),
        _listView(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data;
    final List<MerchantDetail> detail = [
      MerchantDetail(
          question: 'Name', ans: data!.objGetMerchantDetail![0].merchantName),
      MerchantDetail(
          question: 'Mobile No.', ans: data.objGetMerchantDetail![0].mobileNo),
      MerchantDetail(
          question: 'Email Id', ans: data.objGetMerchantDetail![0].emailId),
    ];
    return SizedBox(
      height: screenHeight(context) * 0.50,
      child: ListView.builder(
        itemCount: detail.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldText(detail[index].question!, fontSize: 16.0),
                  normalText(detail[index].ans!, fontSize: 16.0)
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
            ],
          );
        },
      ),
    );
  }
}
