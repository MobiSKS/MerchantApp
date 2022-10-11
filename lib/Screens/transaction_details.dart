import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/model/transaction_detail_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import '../base/base_view.dart';
import '../provider/financials_provider.dart';
import '../util/utils.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  DateTime selectedDate = DateTime.now();
  bool _dataReceived = false;
  String _selectedType = "";
  final TextEditingController _terminalIdController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
        title: boldText(AppStrings.transactionDetails,
            color: Colors.black, fontSize: 20),
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
    return BaseView<FinancialsProvider>(onModelReady: (model) async {
      await model.getTransactionType(context);
    }, builder: (context, financialPro, child) {
      return financialPro.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _searchFilter(financialPro),
                _dataReceived
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
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
                      )
                    : Container(),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                _dataReceived
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:
                            _searchResults(financialPro.transactionDetailModel),
                      ))
                    : Container()
              ],
            );
    });
  }

  Widget _searchFilter(FinancialsProvider financialPro) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context) * 0.04),
          simpleTextField(context, _fromDateController, 'From Date',
              showIcon: true, onTap: () {
            Utils.selectDatePopup(context, selectedDate, _fromDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _toDateController, 'To Date', showIcon: true,
              onTap: () {
            Utils.selectDatePopup(context, selectedDate, _toDateController);
          }),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(
              context, _terminalIdController, "Terminal Id (Optional) "),
          SizedBox(height: screenHeight(context) * 0.01),
          _selectProduct(context, financialPro),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.search, onTap: () {
            getTransactionDetail(financialPro);
          })
        ],
      ),
    );
  }

  Future<void> getTransactionDetail(FinancialsProvider financialPro) async {
    await financialPro.getTransactionDetail(context,
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        terminalId: _terminalIdController.text,
        transType: _selectedType);

    if (financialPro.transactionDetailModel!.internelStatusCode == 1000) {
      setState(() {
        _dataReceived = true;
      });
    }
  }

  Widget _selectProduct(BuildContext context, FinancialsProvider financialPro) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      height: 45,
      child: Center(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              enabledBorder: InputBorder.none, enabled: false),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          hint: semiBoldText('Select Transaction Type'),
          value: _selectedType.isEmpty ? null : _selectedType,
          items: financialPro.transactionType!.data!.map((value) {
            return DropdownMenuItem(
              value: value.transactionID.toString(),
              child: Text(value.transactionType!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedType = value!;
            });
          },
        ),
      ),
    );
  }

  Widget _searchResults(TransactionDetailModel? transactionDetailModel) {
    return CustomList(
      list: transactionDetailModel!.data!,
      itemSpace: 20,
      child: (Data data, index) {
        return _transactionCard(data);
      },
    );
  }

  Widget _transactionCard(Data data) {
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
                  boldText('Transaction Summary',
                      color: Colors.black, fontSize: 16),
                  Row(
                    children: [
                      normalText('View Detail'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 
                    children: [
                      Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(
                            'Name',
                            color: Colors.black,
                          ),
                          boldText(
                            data.nameOnCard!,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          normalText(
                            'Amount',
                            color: Colors.black,
                          ),
                          boldText(
                            '₹${data.amount!}',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  normalText(
                    'Mobile no./Card Number',
                    color: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                  boldText('${data.mobileNo!}/${data.cardNo}',
                      color: Colors.black, fontSize: 16),
                  SizedBox(height: screenHeight(context) * 0.01),
                ],
              ),
            ],
          ),
        ),
        _transactionID(data)
      ],
    );
  }

  Widget _transactionID(Data data) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.indigo.shade200,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          normalText(
            data.transactionDate!,
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
