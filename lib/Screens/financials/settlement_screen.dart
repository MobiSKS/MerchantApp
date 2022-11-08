// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/Screens/financials/payment_screen.dart';
import 'package:dtplusmerchant/Screens/financials/settlement_detail.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/common/slide_button.dart';
import 'package:dtplusmerchant/model/settlement_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../const/app_strings.dart';
import '../../provider/financials_provider.dart';
import '../../util/uiutil.dart';

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
      text: Utils.convertDateFormatInYYMMDD(DateTime.now()));
  final _toDateController = TextEditingController(
      text: Utils.convertDateFormatInYYMMDD(DateTime.now()));
  final _terminalIdController = TextEditingController();
  double columnPadding = 20;
  final settlementdata1 = ValueNotifier<List<Data>>([]);
  List<Data> settlementdata = [];
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
          ? SingleChildScrollView(
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: _body(context))
          : Scaffold(
              appBar: normalAppBar(context,
                  title: AppStrings.paymentNsettlement, showTitle: false),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics()),
                  child: _body(context)),
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
          ? screenHeight(context) * 0.71
          : screenHeight(context) * 0.75,
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
          Expanded(
            child: BaseView<FinancialsProvider>(
              onModelReady: (model) async {
                await model.getSettlementDetail(context);
              },
              builder: (context, financialpro, child) {
                settlementdata = financialpro.isLoading ||
                        financialpro.settlementModel == null
                    ? []
                    : financialpro.settlementModel!.data!;
                settlementdata1.value = settlementdata;
                return financialpro.isLoading
                    ? Column(
                        children: [
                          SizedBox(height: screenHeight(context) * 0.30),
                          const CircularProgressIndicator(),
                        ],
                      )
                    : financialpro.settlementModel != null
                        ? SingleChildScrollView(child: _settlementData())
                        : Column(
                            children: [
                              SizedBox(height: screenHeight(context) * 0.30),
                              semiBoldText('No Settlement found'),
                            ],
                          );
              },
            ),
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

  Widget _settlementData() {
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
                children: [
                  SizedBox(height: screenHeight(context) * 0.03),
                  CustomList(
                      list: value,
                      itemSpace: 10,
                      child: (data, index) {
                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettlementDetail(
                                              settlementData: data,
                                            )),
                                  );
                                },
                                child: _settlementList(context, data)),
                            const SizedBox(height: 10),
                            Divider(
                              color: Colors.grey.shade700,
                            )
                          ],
                        );
                      })
                ],
              ));
  }

  Widget _settlementList(BuildContext context, Data data) {
    return SizedBox(
      width: screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            semiBoldText('Batch Id:  ${data.batchId}',
                color: Colors.grey.shade900, fontSize: 18.0),
            const SizedBox(height: 5),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Status: ',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                          fontFamily: FontFamilyHelper.sourceSansSemiBold)),
                  TextSpan(
                    text: '${data.status} ',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontFamily: FontFamilyHelper.sourceSansSemiBold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            semiBoldText('Terminal Id:  ${data.terminalId}',
                color: Colors.grey.shade600, fontSize: 18.0),
            const SizedBox(height: 5),
            semiBoldText('No. Of Transaction:   ${data.noofTransactions}',
                color: Colors.grey.shade600, fontSize: 18.0),
            const SizedBox(height: 5),
            semiBoldText('Sttlement Date:  ${data.settlementDate}',
                color: Colors.grey.shade600, fontSize: 18.0),
            const SizedBox(height: 5),
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettlementDetail(
                                settlementData: data,
                              )),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 30,
                  ))
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
                          child: simpleTextField(
                              context, _fromDateController, 'From Date',
                              showIcon: true, enabled: false),
                        ),
                        const SizedBox(height: 15),
                        semiBoldText('To Date',
                            color: Colors.grey.shade700, fontSize: 18),
                        GestureDetector(
                          onTap: () => Utils.selectDatePopup(
                              context, DateTime.now(), _toDateController),
                          child: simpleTextField(
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
    FinancialsProvider fPro =
        Provider.of<FinancialsProvider>(context, listen: false);
    if (_fromDateController.text.isNotEmpty &&
        _toDateController.text.isNotEmpty) {
      showLoader(context);
      await fPro.getSettlementDetail(context,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          terminalId: _terminalIdController.text);
      dismissLoader(context);

      if (fPro.transactionDetailModel != null &&
          fPro.transactionDetailModel!.internelStatusCode == 1000) {
        _settlementSearchController.clear();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else {
      alertPopUp(context, 'Please enter from and to date');
    }
  }
}
