import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import '../util/utils.dart';

class ReceivablePayable extends StatefulWidget {
  const ReceivablePayable({super.key});

  @override
  State<ReceivablePayable> createState() => _ReceivablePayableState();
}

class _ReceivablePayableState extends State<ReceivablePayable> {
  List<String> transactionList = ['1', '2', '3', '4'];
  DateTime selectedDate = DateTime.now();
  final TextEditingController _terminalController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  
         
       

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
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
        title: headerText(AppStrings.receivablePayableDetail,
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(ImageResources.notificationIcon))
        ],
      ),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _searchFilter(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.06,
            color: Colors.indigo.shade200,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: headerText('Search Results',
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight(context) * 0.03,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _searchResults(),
        )),
      ],
    );
  }

  Widget _searchFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context) * 0.04),
          simpleTextField(context, _fromDateController, 'From Date',
              showIcon: true, onTap: () {
            Utils.selectDatePopup(context, selectedDate,_fromDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _toDateController, 'To Date', showIcon: true,
              onTap: () {
            Utils.selectDatePopup(context,selectedDate, _toDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _terminalController, "Terminal ID"),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.search, onTap: () {})
        ],
      ),
    );
  }

  Widget _searchResults() {
    return CustomList(
      list: transactionList,
      itemSpace: 20,
      child: (String data, index) {
        return _payableCard();
      },
    );
  }

  Widget _payableCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          width: screenWidth(context),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headerText('Transaction Summary',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  Row(
                    children: [
                      smallText('View Detail', fontWeight: FontWeight.normal),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 15, color: Colors.black)
                    ],
                  )
                ],
              ),
              Divider(color: Colors.indigo.shade400),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  smallText('Settlement Date',
                      color: Colors.black,
                      align: TextAlign.start,
                      fontWeight: FontWeight.normal),
                  headerText('25-06-2021',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText('Receivable Amount',
                              color: Colors.black,
                              align: TextAlign.start,
                              fontWeight: FontWeight.normal),
                          headerText('₹3000',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText('Payable Amount',
                              color: Colors.black,
                              align: TextAlign.start,
                              fontWeight: FontWeight.normal),
                          headerText('₹3000',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                ],
              ),
            ],
          ),
        ),
        _transactionID()
      ],
    );
  }

  Widget _transactionID() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.indigo.shade300,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          smallText('Batch ID: BIDI1234',
              color: Colors.black, fontWeight: FontWeight.normal),
          smallText('Terminal ID: TRMID123456',
              color: Colors.black, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}
