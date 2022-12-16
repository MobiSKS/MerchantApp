import 'package:dtplusmerchant/util/utils.dart';
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
        semiBoldText(AppStrings.contactPersonDetail,
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
          key: 'Name', value: Utils.checkNullValue(data!.objGetMerchantDetail![0].contactPersonName) ),
      MerchantDetail(
          key: 'Mobile No.', value: Utils.checkNullValue(data.objGetMerchantDetail![0].mobileNo)),
      MerchantDetail(
          key: 'Email Id', value: Utils.checkNullValue(data.objGetMerchantDetail![0].emailId)),
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
