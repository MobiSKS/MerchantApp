import 'package:dtplusmerchant/Screens/financials/payment_screen.dart';
import 'package:dtplusmerchant/Screens/financials/settlement_detail.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/common/slide_button.dart';
import 'package:dtplusmerchant/model/settlement_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import '../../base/base_view.dart';
import '../../const/app_strings.dart';
import '../../provider/financials_provider.dart';
import '../../util/uiutil.dart';

class SettlementScreen extends StatefulWidget {
  const SettlementScreen({super.key});

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  final PageController pageController = PageController();
  int pageIndex = 0;
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _terminalIdController = TextEditingController();
  double columnPadding = 20;
  bool _dataLoaded = false;
  final List<Payment> transactions = [
    Payment(
        name: 'Ram Kumar',
        amount: '520',
        date: '13 JUL 2022',
        time: '10:00 AM'),
    Payment(
        name: 'John Cena',
        amount: '678',
        date: '13 JUL 2022',
        time: '10:55 AM'),
    Payment(
        name: 'Ram Kumar',
        amount: '520',
        date: '13 JUL 2022',
        time: '10:00 AM'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: normalAppBar(context, title: AppStrings.paymentNsettlement),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics:
                const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: _body(context)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context) * 0.01),
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
      height: screenHeight(context) * 0.75,
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
    return BaseView<FinancialsProvider>(
      builder: (context, financialpro, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Utils.selectDatePopup(
                        context, DateTime.now(), _fromDateController),
                    child: simpleTextField(
                        context, _fromDateController, 'From Date',
                        showIcon: true, enabled: false),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 25),
                  _dataLoaded
                      ? Row(
                          children: [
                            semiBoldText("Available for Settlements",
                                color: Colors.grey.shade700, fontSize: 20),
                            const Spacer(),
                            boldText("₹ 20,979",
                                color: Colors.black, fontSize: 20),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  customButton(context, AppStrings.submit, onTap: () {
                    getSettlementData(financialpro);
                  }),
                  SizedBox(height: screenHeight(context) * 0.02),
                ],
              ),
            ),
            _dataLoaded
                ? Column(
                    children: [
                      _searchResultBar(context),
                    ],
                  )
                : Container(),
            SizedBox(height: screenHeight(context) * 0.03),
            _dataLoaded
                ? Expanded(
                    child: SingleChildScrollView(
                        child: CustomList(
                            list: financialpro.settlementModel!.data,
                            itemSpace: 10,
                            child: (data, index) {
                              return Column(
                                children: [
                                  _settlementList(context, data),
                                  const SizedBox(height: 10),
                                  Divider(
                                    color: Colors.grey.shade700,
                                    endIndent: 20,
                                    indent: 20,
                                  )
                                ],
                              );
                            })),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  Future<void> getSettlementData(FinancialsProvider fPro) async {
    if (_fromDateController.text.isNotEmpty &&
        _toDateController.text.isNotEmpty) {
      await fPro.getSettlement(context,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          terminalID: _terminalIdController.text);
      if (fPro.settlementModel != null &&
          fPro.settlementModel!.internelStatusCode == 1000) {
        setState(() {
          _dataLoaded = true;
        });
      }
    } else {
      alertPopUp(context, 'Please enter from and to date');
    }
  }

  Widget _settlementList(
    BuildContext context,
    Data data,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettlementDetail()),
        );
      },
      child: SizedBox(
        width: screenWidth(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          text: 'JDE Status: ',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 18,
                              fontFamily: FontFamilyHelper.sourceSansSemiBold)),
                      TextSpan(
                        text: '${data.jDEStatus} ',
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
                semiBoldText('Sale:  ₹ ${data.sale}',
                    color: Colors.grey.shade600, fontSize: 18.0),
                const SizedBox(height: 5),
                semiBoldText('Reload:  ₹ ${data.reload}',
                    color: Colors.grey.shade600, fontSize: 18.0),
                const SizedBox(height: 5),
                semiBoldText('Earning:  ₹ ${data.earning}',
                    color: Colors.grey.shade600, fontSize: 18.0),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        semiBoldText(data.settlementDate!.split(" ")[0],
                            color: Colors.grey.shade600, fontSize: 18.0),
                        const SizedBox(width: 5),
                        semiBoldText(data.settlementDate!.split(" ")[1],
                            color: Colors.grey.shade700, fontSize: 18.0),
                      ],
                    ),
                  ],
                ),
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettlementDetail()),
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
        ),
      ),
    );
  }

  Widget _searchResultBar(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.055,
      color: Colors.indigo.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child:
                semiBoldText("Settlements", color: Colors.black, fontSize: 19),
          ),
        ],
      ),
    );
  }
}

class Payment {
  String? name;
  String? date;
  String? time;
  String? amount;
  String? payMode;
  Payment({this.amount, this.date, this.name, this.payMode, this.time});
}
