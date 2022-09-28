import 'package:flutter/material.dart';
import '../common/custom_list.dart';
import '../const/app_strings.dart';
import '../const/image_resources.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';

class ERPDetail extends StatefulWidget {
  const ERPDetail({super.key});

  @override
  State<ERPDetail> createState() => _ERPDetailState();
}

class _ERPDetailState extends State<ERPDetail> {
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
        title: boldText(AppStrings.erpDetail,
            color: Colors.black,  fontSize: 20),
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
              child: boldText(AppStrings.searchResult,
                  color: Colors.black,),
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
          simpleTextField(context, _fromDateController, AppStrings.fromDate,
              showIcon: true, onTap: () {
            Utils.selectDatePopup(context, selectedDate, _fromDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _toDateController, AppStrings.toDate,
              showIcon: true, onTap: () {
            Utils.selectDatePopup(context, selectedDate, _toDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _terminalController, AppStrings.terminalID),
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
        return _erpCard();
      },
    );
  }

  Widget _erpCard() {
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
                  boldText(AppStrings.erpSummary,
                      color: Colors.black,
                      fontSize: 16,
                  ),
                  Row(
                    children: [
                      normalText(AppStrings.viewDetail,
                      ),
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(AppStrings.settlementDate,
                              color: Colors.black,
                              textAlign: TextAlign.start,
                      ),
                          boldText('25-06-2021',
                              color: Colors.black,
                              fontSize: 16),
                        ],
                      ),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(AppStrings.sale,
                              color: Colors.black,
                              textAlign: TextAlign.start,
                            ),
                          boldText('XYZ',
                              color: Colors.black,
                              fontSize: 16,
                             ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                            'Receivable Amount',
                            color: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          boldText(
                            '₹3000',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                            'JDE Status',
                            color: Colors.black,
                            textAlign: TextAlign.start,
                          ),
                          boldText(
                            'ABC',
                            color: Colors.black,
                            fontSize: 16,
                          ),
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
          normalText(
            'Terminal ID: TRMID123456',
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
