// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:dtplusmerchant/Screens/financials/transaction_summary_detail.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../common/custom_list.dart';
import '../../const/app_strings.dart';
import '../../model/transaction_detail_model.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final transdata1 = ValueNotifier<List<Data>>([]);
  List<Data> transdata = [];
  List<String> dropdownValues = ["Today", "Yesterday", "Last 7 Days"];
  late int diffPayment;
  final TextEditingController _paymentSearchController =
      TextEditingController();
  final TextEditingController _fromDateController = TextEditingController(
      text: Utils.convertDateFormatInYYMMDD(dateT:DateTime.now()));
  final TextEditingController _toDateController = TextEditingController(
      text: Utils.convertDateFormatInYYMMDD(dateT:DateTime.now()));
  final TextEditingController _terminalIdController = TextEditingController();
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
          Expanded(
            child: BaseView<FinancialsProvider>(onModelReady: (model) async {
              await model.getTransactionDetail(context);
            }, builder: (context, financeViewM, child) {
              transdata = financeViewM.isLoading ||
                      financeViewM.transactionDetailModel == null
                  ? []
                  : financeViewM.transactionDetailModel!.data!;
              transdata1.value = transdata;
              return financeViewM.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight(context) * 0.30),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : financeViewM.transactionDetailModel != null
                      ? SingleChildScrollView(child: _paymentData())
                      : Column(
                          children: [
                            SizedBox(height: screenHeight(context) * 0.30),
                            semiBoldText('No Transaction found'),
                          ],
                        );
            }),
          ),
        ],
      ),
    );
  }

  void onChanged() {
    if (_paymentSearchController.text.isNotEmpty) {
      transdata1.value = transdata
          .where((e) => e.nameOnCard!
              .toUpperCase()
              .contains(_paymentSearchController.text.toUpperCase()))
          .toList();
      _paymentData();

      log(transdata1.value.length.toString());
    } else {
      transdata1.value = transdata;
    }
  }

  Widget _paymentData() {
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
                children: [
                  SizedBox(height: screenHeight(context) * 0.03),
                  CustomList(
                      //   physics: const AlwaysScrollableScrollPhysics(),
                      list: value,
                      itemSpace: 5,
                      child: (Data data, index) {
                        return Column(
                          children: [
                            _listItem(context, data),
                            const SizedBox(height: 10),
                            Divider(
                              color: Colors.grey.shade700,
                            )
                          ],
                        );
                      }),
                ],
              ));
  }

  Widget _listItem(BuildContext context, Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TransactionSummarydetail(data: data)),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Utils.getRamdomColor(),
                child: Center(
                    child: semiBoldText(Utils.getNameInitials(data.nameOnCard),
                        color: Colors.white, fontSize: 20)),
              ),
              SizedBox(width: screenWidth(context) * 0.03),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                semiBoldText(data.nameOnCard!,
                    color: Colors.grey.shade800, fontSize: 18.0),
                const SizedBox(height: 5),
                semiBoldText('TID : ${data.terminalId!}',
                    color: Colors.grey.shade500, fontSize: 18.0),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        semiBoldText(
                          data.transactionDate!,
                          fontSize: 18.0,
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Row(
            children: [
              semiBoldText(
                '₹ ${data.amount!}',
                color: Colors.grey.shade800,
              ),
              const SizedBox(width: 8)
            ],
          )
        ],
      ),
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
              height: screenHeight(context) * 0.50,
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
                        semiBoldText('From Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _fromDateController),
                          child: dateTextField(
                              context, _fromDateController, 'From Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(height: 15),
                        semiBoldText('To Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _toDateController),
                          child: dateTextField(
                              context, _toDateController, 'To Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(height: 15),
                        simpleTextField(
                          context,
                          _terminalIdController,
                          'Terminal Id (Optional)',
                        ),
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
    if (_fromDateController.text.isNotEmpty &&
        _toDateController.text.isNotEmpty) {
      showLoader(context);
      await fPro.getTransactionDetail(context,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          terminalId: _terminalIdController.text);
      dismissLoader(context);

      if (fPro.transactionDetailModel != null &&
          fPro.transactionDetailModel!.internelStatusCode == 1000) {
        _paymentSearchController.clear();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else {
      alertPopUp(context, 'Please enter from and to date');
    }
  }
}
