import 'package:dtplusmerchant/Screens/financials/receivable_payable_detail_screen.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/model/receivable_payable_model.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/utils.dart';

class ReceivablePayable extends StatefulWidget {
  const ReceivablePayable({super.key});

  @override
  State<ReceivablePayable> createState() => _ReceivablePayableState();
}

class _ReceivablePayableState extends State<ReceivablePayable> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _terminalController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: normalAppBar(context, title: AppStrings.receivablePayableDetail),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _searchFilter(),
        SizedBox(height: screenHeight(context) * 0.03),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 00),
          child: _searchResults(),
        )),
      ],
    );
  }

  Widget _searchFilter() {
    var financialPro = Provider.of<FinancialsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context) * 0.02),
          GestureDetector(
            onTap: () {
              Utils.selectDatePopup(context, selectedDate, _fromDateController);
            },
            child: simpleTextField(context, _fromDateController, 'From Date',
                showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          GestureDetector(
            onTap: () =>
                Utils.selectDatePopup(context, selectedDate, _toDateController),
            child: simpleTextField(context, _toDateController, 'To Date',
                showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(
              context, _terminalController, "Terminal ID (optional)"),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.search, onTap: () async {
            await financialPro.receivablePayableDetails(context,
                fromDate: _fromDateController.text,
                terminalId: _terminalController.text,
                toDate: _toDateController.text);
          })
        ],
      ),
    );
  }

  Widget _searchResults() {
    return Consumer<FinancialsProvider>(
      builder: (context, value, _) {
        return value.receivablePayableResponseModel != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: Container(
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.06,
                      color: Colors.indigo.shade200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, top: 15),
                        child: boldText(
                          'Search Results',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CustomList(
                      list: value.receivablePayableResponseModel!.data!,
                      itemSpace: 20,            
                      child: (context, index) {
                        return _payableCard(
                            value.receivablePayableResponseModel!.data![index]);
                      },
                    ),
                  ),
                ],
              )
            : Container();
      },
    );
  }

  Widget _payableCard(Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceivablePayableDetailsScreen(
                      dataItem: data,
                    )));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            width: screenWidth(context),
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    boldText(
                      'Transaction Summary',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    Row(
                      children: [
                        normalText(
                          'View Detail',
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
                    normalText(
                      'Settlement Date',
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    boldText(
                        /*'25-06-2021'*/ "${data.settlementDate.toString().characters.take(10)}",
                        color: Colors.black,
                        fontSize: 16),
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
                              '₹${data.receivable}',
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
                              'Payable Amount',
                              color: Colors.black,
                              textAlign: TextAlign.start,
                            ),
                            boldText(
                              '₹${data.payable}',
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
          _transactionID(data)
        ],
      ),
    );
  }

  Widget _transactionID(Data data) {
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
            'Batch ID: ${data.batchId}',
            color: Colors.black,
          ),
          normalText(
            'Terminal ID: ${data.terminalId}',
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
