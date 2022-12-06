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
        semiBoldText(AppStrings.merchantprofile,
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
          key: 'Merchant Type',
          value: data.objOutletDetails!.first.merchantTypeName!),
      MerchantDetail(
          key: 'Outlet Category',
          value: data.objOutletDetails!.first.outletCategoryName!),
      MerchantDetail(
          key: 'Merchant Id',
          value: data.objGetMerchantDetail!.first.merchantId),
      MerchantDetail(
          key: 'Retail Outlet Name',
          value: data.objOutletDetails!.first.retailOutletName),
      MerchantDetail(
          key: 'Merchant Name',
          value: data.objGetMerchantDetail!.first.merchantName!),
      MerchantDetail(
          key: 'GST no.',
          value: data.objOutletDetails!.first.gSTNumber ?? "NA"),
             MerchantDetail(
          key: 'PAN No.',
          value: data.objGetMerchantDetail!.first.pancard ?? "NA"),
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
                  normalText(detail[index].key!,
                      fontSize: 18.0,),
                  normalText(detail[index].value!, fontSize:17.0,color: Colors.grey.shade800)
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
  String? key;
  String? value;

  MerchantDetail({this.key, this.value});
}
