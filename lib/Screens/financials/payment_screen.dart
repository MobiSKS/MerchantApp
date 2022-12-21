// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:dtplusmerchant/const/common_param.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../common/custom_list.dart';
import '../../const/app_strings.dart';
import '../../model/payment_model.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final transdata1 = ValueNotifier<List<TransactionDetails>>([]);
  List<TransactionDetails> transdata = [
    
  ];
  late int diffPayment;
  final TextEditingController _paymentSearchController =
      TextEditingController();
  final TextEditingController _fromDateController = TextEditingController(
      text: Utils.convertDateFormatInYYMMDD(dateT: DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeight(context) * 0.020),
              searchWidget(context, _paymentSearchController,
                  hintText: 'Search Payments',
                  onTap: showBottomModalSheet,
                  onChanged: onChanged),
            ],
          ),
          BaseView<FinancialsProvider>(onModelReady: (model) async {
            await model.getPaymentList(context);
          }, builder: (context, financeViewM, child) {
            transdata =
                financeViewM.isLoading || financeViewM.paymentModel == null
                    ? []
                    : financeViewM.paymentModel!.data!.transactionDetails!;
            transdata1.value = transdata;
            return financeViewM.isLoading
                ? Column(
                    children: [
                      SizedBox(height: screenHeight(context) * 0.30),
                      const CircularProgressIndicator(),
                    ],
                  )
                : financeViewM.paymentModel != null
                    ? Expanded(
                        child: _paymentData(
                            paymentDetail: financeViewM
                                .paymentModel!.data!.paymentDetails),
                      )
                    : Column(
                        children: [
                          SizedBox(height: screenHeight(context) * 0.30),
                          semiBoldText('No Transaction found'),
                        ],
                      );
          }),
        ],
      ),
    );
  }

  void onChanged() {
    if (_paymentSearchController.text.isNotEmpty) {
      transdata1.value = transdata
          .where((e) => e.batchId!
              .toString()
              .toUpperCase()
              .contains(_paymentSearchController.text.toUpperCase()))
          .toList();
      _paymentData();

      log(transdata1.value.length.toString());
    } else {
      transdata1.value = transdata;
    }
  }

  Widget _paymentData({List<PaymentDetails>? paymentDetail}) {
    return ValueListenableBuilder(
        valueListenable: transdata1,
        builder: (_, value, __) => transdata1.value.isEmpty
            ? Column(
                children: [
                  SizedBox(height: screenHeight(context) * 0.3),
                  Center(child: semiBoldText('No Data Found')),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight(context) * 0.01),
                  semiBoldText(
                      'Total Amount: $rupeeSign ${paymentDetail!.first.totalAmout}'),
                  const SizedBox(height: 5),
                  semiBoldText(
                      'No. of Payments: ${paymentDetail.first.noOfPayments}'),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Expanded(
                    child: CustomList(
                        list: value,
                        itemSpace: 5,
                        child: (TransactionDetails data, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _listItem(context, data),
                              const SizedBox(height: 10),
                              Divider(
                                color: Colors.grey.shade700,
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ));
  }

  Widget _listItem(BuildContext context, TransactionDetails data) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => TransactionSummarydetail(data: data)),
        // );
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        semiBoldText('Batch Id : ${data.batchId}',
            color: Colors.grey.shade800, fontSize: 16.0),
        const SizedBox(height: 5),
        semiBoldText('Amount :$rupeeSign ${data.amount}',
            color: Colors.grey.shade600, fontSize: 16.0),
        const SizedBox(height: 5),
        semiBoldText('Terminal ID : ${data.terminalId!}',
            color: Colors.grey.shade600, fontSize: 16.0),
        const SizedBox(height: 5),
        semiBoldText('Merchant ID : ${data.merchantId!}',
            color: Colors.grey.shade600, fontSize: 16.0),
        const SizedBox(height: 5),
        semiBoldText(
          'Transaction Date :   ${data.transactionDate!}',
          fontSize: 16.0,
          color: Colors.grey.shade600,
        ),
        const SizedBox(height: 5),
        semiBoldText(
          'Transaction type :   ${data.transactionType!}',
          fontSize: 16.0,
          color: Colors.grey.shade600,
        ),
      ]),
    );
  }

  void showBottomModalSheet() {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: ((BuildContext context, StateSetter setState) {
            return SizedBox(
              height: screenHeight(context) * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 20),
                    child: semiBoldText('Search Filter',
                        color: Colors.black, fontSize: 25),
                  ),
                  Divider(
                    color: Colors.grey.shade900,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        semiBoldText('Select Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _fromDateController),
                          child: dateTextField(
                              context, _fromDateController, 'Select Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(height: screenHeight(context) * 0.07),
                        customButton(context, AppStrings.submit, onTap: () {
                          getFilterData();
                        }),
                        SizedBox(height: screenHeight(context) * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }));
        });
  }

  Future<void> getFilterData() async {
    FinancialsProvider fPro =
        Provider.of<FinancialsProvider>(context, listen: false);
    if (_fromDateController.text.isNotEmpty) {
      showLoader(context);
      await fPro.getPaymentList(
        context,
        date: _fromDateController.text,
      );
      dismissLoader(context);

      if (fPro.paymentModel != null &&
          fPro.paymentModel!.internelStatusCode == 1000) {
        _paymentSearchController.clear();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else {
      alertPopUp(context, 'Please enter  date');
    }
  }
}
