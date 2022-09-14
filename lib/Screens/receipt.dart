import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';

import '../const/image_resources.dart';
import '../util/uiutil.dart';

class Receipt extends StatelessWidget {
  Receipt({super.key});

  List<String> receiptEntity = [
    'Location',
    'Terminal ID',
    'Batch No.',
    'ROC',
    'Transaction Date',
    'Transaction ID',
    'Mobile Number',
    'Transaction Type',
    'Transaction Date',
    'Product Name',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.black, size: 24)),
        title: headerText(AppStrings.receipt,
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(ImageResources.notificationIcon))
        ],
      ),
      body: SingleChildScrollView(child: _body(context)),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenHeight(context) * 0.05),
        hpLogo(context),
        SizedBox(height: screenHeight(context) * 0.07),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _receiptDetail(),
        ),
      ],
    );
  }

  Widget _receiptDetail() {
    return CustomList(
      list: receiptEntity,
      itemSpace: 10,
      child: (String data, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText(data,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16),
                headerText(data,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16)
              ],
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.blueGrey)
          ],
        );
      },
    );
  }
}
