import 'package:flutter/material.dart';

import '../../const/app_strings.dart';
import '../../util/uiutil.dart';
import 'merchant_profile.dart';

class RetailOutletAddress extends StatelessWidget {
   RetailOutletAddress({super.key});

 final List<MerchantDetail> _detail = [
    MerchantDetail(question: 'Addrtess 1', ans: '503,Vibgyor Tower'),
    MerchantDetail(question: 'Addrtess 2', ans: 'Opp Hotel Trident Hill '),
    MerchantDetail(question: 'Addrtess 3', ans: 'Bandra Kurla Complex'),
    MerchantDetail(question: 'City', ans: 'Mumbai'),
    MerchantDetail(question: 'District', ans: 'Mumbai'),
    MerchantDetail(question: 'State', ans: 'Maharashta'),
    MerchantDetail(question: 'Pin Code', ans: '400051'),
    MerchantDetail(question: 'Office Phone', ans: '011-2343654'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText(AppStrings.retailOutletAddress,
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
            const  SizedBox(height: 10),
              const Divider(color: Colors.grey),
            ],
          );
        },
      ),
    );
  }
}