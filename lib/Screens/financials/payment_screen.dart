// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:dtplusmerchant/const/common_param.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../common/custom_list.dart';
import '../../const/app_strings.dart';
import '../../model/payment_model.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';
import "package:collection/collection.dart" as collection;
import 'dart:math' as math;

import 'package:expandable/expandable.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final transdata1 = ValueNotifier<List<TransactionDetails>>([]);
  List<GroupedTransactionSlip> transSlipList = [];
  List<TransactionDetails> transdata = [];
  late int diffPayment;
  final TextEditingController _paymentSearchController =
      TextEditingController();
  final TextEditingController _fromDateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
  final TextEditingController _todateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
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
                  hintText: 'Search Batch ID',
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

  groupTransDetailsByBatchId(List<TransactionDetails> transList) {
    if (transList.isNotEmpty) {
      transSlipList.clear();
      final groups = collection.groupBy(transList, (TransactionDetails e) {
        return e.batchId;
      });
      groups.forEach((batchId, list) {
        transSlipList
            .add(GroupedTransactionSlip(batchId: batchId, transSlipList: list));
      });

      transSlipList.toSet().toList();
    }
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
    groupTransDetailsByBatchId(transdata1.value);
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
                      'Total Amount: $rupeeSign ${Utils.upToDecimalPoint(paymentDetail!.first.totalAmout.toString())}'),
                  const SizedBox(height: 5),
                  semiBoldText(
                      'No. of Payments: ${paymentDetail.first.noOfPayments}'),
                  const SizedBox(height: 5),
                  semiBoldText(
                      'Date: ${_fromDateController.text.isEmpty ? Utils.convertDateFormatInDDMMYY(DateTime.now()) : _fromDateController.text}'),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Expanded(
                    child: CustomList(
                        list: transSlipList,
                        itemSpace: 5,
                        child: (GroupedTransactionSlip data, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _expandebleWidget(context, data),
                            ],
                          );
                        }),
                  ),
                ],
              ));
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        semiBoldText('From Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _fromDateController),
                          child: dateTextField(
                              context, _fromDateController, 'Select Date',
                              showIcon: true, enabled: false),
                        ),
                        semiBoldText('To Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _todateController),
                          child: dateTextField(
                              context, _todateController, 'To Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(height: screenHeight(context) * 0.03),
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

  Widget _expandebleWidget(BuildContext context, GroupedTransactionSlip data) {
    return ExpandableNotifier(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      semiBoldText('Batch ID : ${data.batchId}'),
                      // const SizedBox(height: 5),
                      // semiBoldText(
                      //     'Batch Status : ${data.transSlipList!.first.batchStatus!}'),
                    ],
                  )),
              collapsed: semiBoldText(
                'No. of Payments : ${data.transSlipList!.length}',
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomList(
                    list: data.transSlipList,
                    itemSpace: 10,
                    child: (TransactionDetails data, index) {
                      return _transDetail(data);
                    },
                  )
                  //  _transDetail(data.transSlipList)
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget _transDetail(TransactionDetails? data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          semiBoldText(
              'Amount :$rupeeSign${Utils.upToDecimalPoint(data!.amount.toString())}',
              color: Colors.grey.shade600,
              fontSize: 16.0),
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
            'Transaction type :${data.transactionType!}',
            fontSize: 16.0,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 5),
          semiBoldText(
            'Batch Status :${data.batchStatus!}',
            fontSize: 16.0,
            color: Colors.grey.shade600,
          ),
        ]),
      ),
    );
  }

  Future<void> getFilterData() async {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    FinancialsProvider fPro =
        Provider.of<FinancialsProvider>(context, listen: false);

    if (_fromDateController.text.isNotEmpty &&
        _todateController.text.isNotEmpty) {
      if (dateFormat
              .parse(_fromDateController.text)
              .compareTo(dateFormat.parse(_todateController.text)) >
          0) {
        alertPopUp(context, 'Please enter To Date greater than From date');
      } else {
        showLoader(context);

        await fPro.getPaymentList(
          context,
          fromDate:
              Utils.convertDateFormatInYYMMDD(dateS: _fromDateController.text),
          toDate:
              Utils.convertDateFormatInYYMMDD(dateS: _todateController.text),
        );
        dismissLoader(context);

        if (fPro.paymentModel != null &&
            fPro.paymentModel!.internelStatusCode == 1000) {
          _paymentSearchController.clear();
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      }
    } else {
      alertPopUp(context, 'Please enter  date');
    }
  }
}
