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
        semiBoldText(AppStrings.retailOutletAddress, color: Colors.black,fontSize: 22.0),
        const SizedBox(height: 30),
        _listView(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data;
    final List<MerchantDetail> detail = [
      MerchantDetail(
          key: 'Address 1',
          value: data!.objOutletDetails![0].retailOutletAddress1 ?? ""),
      MerchantDetail(
          key: 'Address 2',
          value: data.objOutletDetails![0].retailOutletAddress2 ?? ""),
      MerchantDetail(
          key: 'Address 3',
          value: data.objOutletDetails![0].retailOutletAddress3 ?? ''),
      MerchantDetail(
          key: 'City', value: data.objOutletDetails![0].retailOutletCity),
      MerchantDetail(key: 'District', value: 'Mumbai'),
      MerchantDetail(key: 'State', value: 'Maharashta'),
      MerchantDetail(
          key: 'Pin Code',
          value: data.objOutletDetails![0].retailOutletPinNumber),
      MerchantDetail(
          key: 'Office Phone',
          value: data.objOutletDetails![0].retailOutletPhoneNumber),
    ];
    return SizedBox(
      height: screenHeight(context) * 0.45,
      child: ListView.builder(
        itemCount: detail.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  semiBoldText(detail[index].key!, fontSize: 20.0),
                  semiBoldText(detail[index].value!, fontSize: 18.0,color:Colors.grey.shade800)
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
