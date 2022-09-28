import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import 'merchant_profile.dart';

class BusinessDetail extends StatelessWidget {
  BusinessDetail({super.key});
  final _sharedPref = Injection.injector.get<SharedPref>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(AppStrings.businessDetail,
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
          question: 'Zonal Office',
          ans: data!.objOutletDetails![0].zonalOfficeName),
      MerchantDetail(
          question: 'Regional Office',
          ans: data.objOutletDetails![0].regionalOfficeName),
      MerchantDetail(
          question: 'Erp code', ans: data.objOutletDetails![0].erpCode),
      MerchantDetail(
          question: 'Sales Area', ans: data.objOutletDetails![0].salesArea),
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
                  boldText(detail[index].ans!, fontSize: 16.0)
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
