import 'package:flutter/material.dart';

import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';
import 'merchant_profile.dart';

class RetailOutletAddress extends StatelessWidget {
  RetailOutletAddress({super.key});
  final _sharedPref = Injection.injector.get<SharedPref>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(AppStrings.retailOutletAddress, color: Colors.black),
        const SizedBox(height: 25),
        _listView(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data;
    final List<MerchantDetail> detail = [
      MerchantDetail(
          question: 'Addrtess 1',
          ans: data!.objOutletDetails![0].retailOutletAddress1 ?? ""),
      MerchantDetail(
          question: 'Addrtess 2',
          ans: data.objOutletDetails![0].retailOutletAddress2 ?? ""),
      MerchantDetail(
          question: 'Addrtess 3',
          ans: data.objOutletDetails![0].retailOutletAddress3 ?? ''),
      MerchantDetail(
          question: 'City', ans: data.objOutletDetails![0].retailOutletCity),
      MerchantDetail(question: 'District', ans: 'Mumbai'),
      MerchantDetail(question: 'State', ans: 'Maharashta'),
      MerchantDetail(
          question: 'Pin Code',
          ans: data.objOutletDetails![0].retailOutletPinNumber),
      MerchantDetail(
          question: 'Office Phone',
          ans: data.objOutletDetails![0].retailOutletPhoneNumber),
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
