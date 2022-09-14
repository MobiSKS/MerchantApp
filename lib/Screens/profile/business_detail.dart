import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import 'merchant_profile.dart';

class BusinessDetail extends StatelessWidget {
  BusinessDetail({super.key});
  final List<MerchantDetail> _detail = [
    MerchantDetail(question: 'Zonal Office', ans: 'ZO Detail'),
    MerchantDetail(question: 'Regional Office', ans: 'RO Detail'),
    MerchantDetail(question: 'Erp code', ans: 'ERP code'),
    MerchantDetail(question: 'Sales Area', ans: 'Sales'),
 
  ];
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
                      fontWeight: FontWeight.bold, size: 14.0),
                  smallText(_detail[index].ans!, fontWeight: FontWeight.normal)
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

