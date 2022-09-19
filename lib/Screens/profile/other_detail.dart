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
        headerText(AppStrings.contactPersonDetail,
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
          question: 'Name', ans: data!.objGetMerchantDetail![0].merchantName),
      MerchantDetail(question: 'Mobile No.', ans: '9995467843'),
      MerchantDetail(question: 'Email Id', ans: 'abc@gmailcom'),
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
                  smallText(_detail[index].ans!,
                      fontWeight: FontWeight.normal, size: 16.0)
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
