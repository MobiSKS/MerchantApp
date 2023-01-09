// ignore_for_file: use_build_context_synchronously
import 'package:dtplusmerchant/Screens/financials/payment_screen.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/common/slide_button.dart';
import 'package:dtplusmerchant/const/common_param.dart';
import 'package:dtplusmerchant/model/payment_model.dart';
import 'package:dtplusmerchant/model/settlement_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../const/app_strings.dart';
import '../../provider/financials_provider.dart';
import '../../util/uiutil.dart';
import "package:collection/collection.dart" as collection;

class SettlementScreen extends StatefulWidget {
  final bool navbar;
  const SettlementScreen({super.key, this.navbar = false});
  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  final TextEditingController _settlementSearchController =
      TextEditingController();
  final PageController pageController = PageController();
  int pageIndex = 0;
  final _fromDateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
  final _toDateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
  double columnPadding = 20;
  final settlementdata1 = ValueNotifier<List<SettleTransactionDetails>>([]);
  List<SettleTransactionDetails> settlementdata = [];
  List<GroupedSettlementData> groupedList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // settlementdata1.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.navbar
          ? _body(context)
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: normalAppBar(context,
                  title: AppStrings.paymentNsettlement, showTitle: false),
              backgroundColor: Colors.white,
              body: _body(context),
            ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context) * 0.02),
        SlideButton(
            pageController: pageController,
            pageIndex: pageIndex,
            labelFirst: AppStrings.payments,
            labelSecond: AppStrings.settlements),
        SizedBox(height: screenHeight(context) * 0.02),
        _pageViewWidget(context),
      ],
    );
  }

  Widget _pageViewWidget(BuildContext context) {
    return SizedBox(
      height: widget.navbar
          ? screenHeight(context) * 0.68
          : screenHeight(context) * 0.72,
      child: PageView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [_paymentWidget(context), _settlementWidget(context)],
      ),
    );
  }

  Widget _paymentWidget(BuildContext context) {
    return const PaymentScreen();
  }

  Widget _settlementWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context) * 0.020),
          searchWidget(context, _settlementSearchController,
              hintText: 'Search Batch Id',
              onTap: showBottomModalSheet,
              onChanged: onChanged),
          const SizedBox(height: 10),
          BaseView<FinancialsProvider>(
            onModelReady: (model) async {
              await model.getSettlementDetail(context);
            },
            builder: (context, financialpro, child) {
              settlementdata =
                  financialpro.isLoading || financialpro.settlementModel == null
                      ? []
                      : financialpro
                          .settlementModel!.data!.settleTransactionDetails!;
              settlementdata1.value = settlementdata;
              return financialpro.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight(context) * 0.30),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : financialpro.settlementModel != null
                      ? Expanded(
                          child: _settlementData(
                              list: financialpro
                                  .settlementModel!.data!.settleMentDetails!))
                      : Column(
                          children: [
                            SizedBox(height: screenHeight(context) * 0.30),
                            semiBoldText('No Settlement found'),
                          ],
                        );
            },
          ),
        ],
      ),
    );
  }

  void onChanged() {
    if (_settlementSearchController.text.isNotEmpty) {
      settlementdata1.value = settlementdata
          .where(
              (e) => e.batchId.toString() == _settlementSearchController.text)
          .toList();
      _settlementData();
    } else {
      settlementdata1.value = settlementdata;
    }
  }

  groupTransDetailsByBatchId(List<SettleTransactionDetails> settleList) {
    if (settleList.isNotEmpty) {
      groupedList.clear();
      final groups =
          collection.groupBy(settleList, (SettleTransactionDetails e) {
        return e.batchId;
      });
      groups.forEach((batchId, list) {
        groupedList
            .add(GroupedSettlementData(batchId: batchId, settlementList: list));
      });

      groupedList.toSet().toList();
    }
  }

  Widget _settlementData({List<SettleMentDetails>? list}) {
    groupTransDetailsByBatchId(settlementdata1.value);
    return ValueListenableBuilder(
        valueListenable: settlementdata1,
        builder: (_, value, __) => settlementdata1.value.isEmpty
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
                      'Total Amount: $rupeeSign ${Utils.upToDecimalPoint(list!.first.totalAmout.toString())}'),
                  const SizedBox(height: 5),
                  semiBoldText(
                      'No. of settlements: ${list.first.noOfSettlement}'),
                  semiBoldText(
                      'Settlement Date: ${_fromDateController.text.isEmpty ? Utils.convertDateFormatInDDMMYY(DateTime.now()) : _fromDateController.text}'),
                  SizedBox(height: screenHeight(context) * 0.03),
                  Expanded(
                    child: CustomList(
                        list: groupedList.toSet().toList(),
                        itemSpace: 10,
                        child: (data, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => SettlementDetail(
                                    //             settlementData: data,
                                    //           )),
                                    // );
                                  },
                                  child: _expandebleWidget(context, data)),
                              const SizedBox(height: 10),
                              Divider(
                                color: Colors.grey.shade700,
                              )
                            ],
                          );
                        }),
                  )
                ],
              ));
  }

  Widget _expandebleWidget(
    BuildContext context,
    GroupedSettlementData data,
  ) {
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
                  child: semiBoldText('Batch ID : ${data.batchId}')),
              collapsed: semiBoldText(
                'No. of Payments : ${data.settlementList!.length}',
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomList(
                    list: data.settlementList,
                    itemSpace: 10,
                    child: (SettleTransactionDetails data, index) {
                      return _settlementDetail(data);
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

  Widget _settlementDetail(SettleTransactionDetails data) {
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
              'Amount: $rupeeSign ${Utils.upToDecimalPoint(data.amount.toString())}',
              color: Colors.grey.shade600,
              fontSize: 16.0),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Terminal Id: ',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontFamily: FontFamilyHelper.sourceSansSemiBold)),
                TextSpan(
                  text: data.terminalId,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontFamily: FontFamilyHelper.sourceSansSemiBold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          semiBoldText('Merchant Id:  ${data.merchantId}',
              color: Colors.grey.shade600, fontSize: 16.0),
          const SizedBox(height: 5),
          semiBoldText('Transaction date:   ${data.transactionDate}',
              color: Colors.grey.shade600, fontSize: 16.0),
          const SizedBox(height: 5),
          semiBoldText('Transaction Type:  ${data.transactionType}',
              color: Colors.grey.shade600, fontSize: 16.0),
          const SizedBox(height: 5),
             semiBoldText('Batch Status:  ${data.batchStatus}',
              color: Colors.grey.shade600, fontSize: 16.0),
          const SizedBox(height: 5),
        ]),
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
                              context, _fromDateController, 'From Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        semiBoldText('To Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _fromDateController),
                          child: dateTextField(
                              context, _fromDateController, 'To Date',
                              showIcon: true, enabled: false),
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        customButton(context, AppStrings.submit, onTap: () {
                          getSettlementFilterData();
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

  Future<void> getSettlementFilterData() async {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    FinancialsProvider fPro =
        Provider.of<FinancialsProvider>(context, listen: false);
    if (_fromDateController.text.isNotEmpty) {
      showLoader(context);
      await fPro.getSettlementDetail(
        context,
        fromDate:
            Utils.convertDateFormatInYYMMDD(dateS: _fromDateController.text),
        toDate: Utils.convertDateFormatInYYMMDD(dateS: _toDateController.text),
      );
      dismissLoader(context);
      if (fPro.transactionDetailModel != null &&
          fPro.transactionDetailModel!.internelStatusCode == 1000) {
        _settlementSearchController.clear();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else {
      alertPopUp(context, 'Please enter date');
    }
  }
}
