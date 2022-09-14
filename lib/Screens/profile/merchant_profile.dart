import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

class Merchantprofile extends StatelessWidget {
  Merchantprofile({super.key});
  final List<MerchantDetail> _detail = [
    MerchantDetail(question: 'Merchant Type', ans: 'Mrch Typ'),
    MerchantDetail(question: 'Outlet Category', ans: 'Out Cat'),
    MerchantDetail(question: 'Merchant Id', ans: 'MrchID1234'),
    MerchantDetail(question: 'Retail Outlet Name', ans: 'RO name'),
    MerchantDetail(question: 'Merchant Name', ans: 'Balwant Singh'),
    MerchantDetail(question: 'GST no.', ans: 'GSTIN123456543'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText(AppStrings.merchantprofile,
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

class MerchantDetail {
  String? question;
  String? ans;

  MerchantDetail({this.question, this.ans});
}
