import 'package:dtplusmerchant/Screens/financials/summary_detail.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/transaction_detail_model.dart'
    as transDetail;
import 'package:dtplusmerchant/model/transaction_type.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../provider/financials_provider.dart';
import '../../util/utils.dart';

class TransactionDetails extends StatefulWidget {
  final TransactionType transType;
  const TransactionDetails(this.transType, {super.key});

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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Center(
              child:
                  normalAppBar(context, title: AppStrings.transactionDetails))),
      body: Column(
        children: [
          title(context, AppStrings.transactionDetails),
          SingleChildScrollView(child: _body(context)),
        ],
      ),
    ));
  }

  Widget _body(BuildContext context) {
    return BaseView<FinancialsProvider>(
        builder: (context, financialPro, child) {
      return Column(
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
                  child: _searchResults(financialPro.transactionDetailModel),
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
          _selectTransactionType(context, financialPro),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.search, onTap: () {
            getTransactionDetail(financialPro);
          })
        ],
      ),
    );
  }

  Future<void> getTransactionDetail(FinancialsProvider financialPro) async {
    var prov = Provider.of<FinancialsProvider>(context, listen: false);
    if ((_fromDateController.text.isNotEmpty &&
            _toDateController.text.isNotEmpty) &&
        _selectedType.isNotEmpty) {
      await prov.getTransactionDetail(context,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          terminalId: _terminalIdController.text,
          transType: _selectedType);

      if (prov.transactionDetailModel!.internelStatusCode == 1000) {
        setState(() {
          _dataReceived = true;
        });
      } else {
        setState(() {
          _dataReceived = false;
        });
      }
    } else {
      alertPopUp(context, 'Please fill all required details');
    }
  }

  Widget _selectTransactionType(
      BuildContext context, FinancialsProvider financialPro) {
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
          hint: boldText('Select Transaction Type',
              color: Colors.grey.shade700, fontSize: 17),
          value: _selectedType.isEmpty ? null : _selectedType,
          items: widget.transType.data!.map((value) {
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

  Widget _searchResults(
      transDetail.TransactionDetailModel? transactionDetailModel) {
    return CustomList(
      list: transactionDetailModel!.data!,
      itemSpace: 20,
      child: (transDetail.Data data, index) {
        return _transactionCard(data);
      },
    );
  }

  Widget _transactionCard(transDetail.Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionSummarydetail(data: data)));
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
      ),
    );
  }

  Widget _transactionID(transDetail.Data data) {
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
