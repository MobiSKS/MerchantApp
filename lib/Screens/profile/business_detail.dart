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
        semiBoldText('Business Detail',
           color: Colors.black,fontSize: 22.0),
        const SizedBox(height: 30),
        _listView(context),
      ],
    );
  }

  Widget _listView(BuildContext context) {
    var data = _sharedPref.user!.data;
    final List<MerchantDetail> detail = [
      MerchantDetail(
          key: 'Zonal Office',
          value: data!.objOutletDetails![0].zonalOfficeName
          ),
      MerchantDetail(
          key: 'Regional Office',
          value: data.objOutletDetails![0].regionalOfficeName),
      MerchantDetail(
          key: 'ERP code', value: data.objOutletDetails![0].erpCode),
      MerchantDetail(
          key: 'Sales Area', value: data.objOutletDetails![0].salesArea),
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
                  normalText(detail[index].key!, fontSize: 18.0),
                  normalText(detail[index].value!, fontSize: 17.0,color:Colors.grey.shade800)
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
