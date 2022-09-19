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
        headerText(AppStrings.businessDetail,
            fontWeight: FontWeight.bold, color: Colors.black),
        const SizedBox(height: 20),
        _listView(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data;
    final List<MerchantDetail> _detail = [
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
        itemCount: _detail.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(_detail[index].question!,
                      fontWeight: FontWeight.bold, size: 16.0),
                  smallText(_detail[index].ans!, fontWeight: FontWeight.normal,size:16.0)
                ],
              ),
              SizedBox(height: 10),
              const Divider(color: Colors.grey),
            ],
          );
        },
      ),
    );
  }
}
