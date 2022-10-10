import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';

class Merchantprofile extends StatelessWidget {
  final _sharedPref = Injection.injector.get<SharedPref>();
  Merchantprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(AppStrings.merchantprofile,
       color: Colors.black, fontSize: 22.0,),
        const SizedBox(height: 30),
        _listView(context),
      ],
    );
  }

  

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data!;
    final List<MerchantDetail> detail = [
      MerchantDetail(
          question: 'Merchant Type',
          ans: data.objOutletDetails![0].merchantTypeName!),
      MerchantDetail(
          question: 'Outlet Category',
          ans: data.objOutletDetails![0].outletCategoryName!),
      MerchantDetail(
          question: 'Merchant Id',
          ans: data.objGetMerchantDetail![0].merchantId),
      MerchantDetail(
          question: 'Retail Outlet Name',
          ans: data.objOutletDetails![0].retailOutletName),
      MerchantDetail(
          question: 'Merchant Name',
          ans: data.objGetMerchantDetail![0].merchantName!),
      MerchantDetail(
          question: 'GST no.',
          ans: data.objOutletDetails![0].gSTNumber ?? "NA"),
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
                  boldText(detail[index].question!,
                      fontSize: 20.0,),
                  semiBoldText(detail[index].ans!, fontSize:18.0)
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

class MerchantDetail {
  String? question;
  String? ans;

  MerchantDetail({this.question, this.ans});
}
