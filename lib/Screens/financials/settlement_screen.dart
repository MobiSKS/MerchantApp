import 'package:dtplusmerchant/Screens/financials/settlement_detail.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/common/slide_button.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';
import '../../const/app_strings.dart';
import '../../util/uiutil.dart';

class SettlementScreen extends StatefulWidget {
  const SettlementScreen({super.key});

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  final PageController pageController = PageController();
  int pageIndex = 0;
  List<String> dropdownValues = ["Today", "Yesterday", "Last 7 Days"];

  double columnPadding = 20;
  late int diffPayment;
  String? _selectedValuePayment;
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
    Payment(
        name: 'John Cena',
        amount: '678',
        date: '13 JUL 2022',
        time: '10:55 AM'),
    Payment(
        name: 'Shyam Kumar',
        amount: '520',
        date: '13 JUL 2022',
        time: '10:00 AM'),
    Payment(
        name: 'Rohan Singh',
        amount: '78',
        date: '13 JUL 2022',
        time: '10:55 AM'),
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
        SizedBox(height: screenHeight(context) * 0.03),
        SlideButton(
            pageController: pageController,
            pageIndex: pageIndex,
            labelFirst: AppStrings.payments,
            labelSecond: AppStrings.settlements),
        SizedBox(height: screenHeight(context) * 0.03),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  DropdownButton(
                    focusColor: Colors.indigo.shade50,
                    isExpanded: false,
                    alignment: Alignment.centerLeft,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 35,
                    ),
                    hint: Text(
                      _selectedValuePayment ?? "Today",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold),
                    ),
                    items: dropdownValues.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) async {
                      switch (newVal) {
                        case "Today":
                          diffPayment = 0;
                          break;
                        case "Yesterday":
                          diffPayment = 1;
                          break;
                        case "Last 7 Days":
                          diffPayment = 7;
                          break;
                        default:
                          _selectedValuePayment = "Today";
                          break;
                      }

                      setState(() {
                        _selectedValuePayment = newVal;
                      });
                    },
                  ),
                  const Spacer(),
                  boldText(
                    "Payment Trends",
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  boldText(
                    "No of Transactions",
                    color: Colors.grey.shade500,
                  ),
                  const Spacer(),
                  boldText(
                    "Total",
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  boldText(
                    '50',
                    color: Colors.black,
                  ),
                  const Spacer(),
                  boldText(
                    "₹ 20,979",
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: screenHeight(context) * 0.03),
            ],
          ),
        ),
        Column(
          children: [
            _searchResultBar(
              context,
            ),
          ],
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        transactions.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(38.0),
                child: Center(
                  child: Text("No Transactions Found"),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                    child: CustomList(
                        list: transactions,
                        itemSpace: 20,
                        child: (Payment data, index) {
                          return _listItem(context, data);
                        })),
              ),
      ],
    );
  }

  Widget _settlementWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  DropdownButton(
                    focusColor: Colors.indigo.shade50,
                    isExpanded: false,
                    alignment: Alignment.centerLeft,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 35,
                    ),
                    hint: semiBoldText(
                      _selectedValuePayment ?? "Today",
                      color: Colors.grey.shade700,
                      fontSize: 20,
                    ),
                    items: dropdownValues.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) async {
                      switch (newVal) {
                        case "Today":
                          diffPayment = 0;
                          break;
                        case "Yesterday":
                          diffPayment = 1;
                          break;
                        case "Last 7 Days":
                          diffPayment = 7;
                          break;
                        default:
                          _selectedValuePayment = "Today";
                          break;
                      }

                      setState(() {
                        _selectedValuePayment = newVal;
                      });
                    },
                  ),
                  const Spacer(),
                  semiBoldText("Settlement Summary",
                      color: Colors.grey.shade700, fontSize: 20),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  semiBoldText("Available for Settlements",
                      color: Colors.grey.shade700, fontSize: 20),
                  const Spacer(),
                  boldText("₹ 20,979", color: Colors.black, fontSize: 20),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(height: screenHeight(context) * 0.02),
            ],
          ),
        ),
        Column(
          children: [
            _searchResultBar(
              context,
            ),
          ],
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        transactions.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(38.0),
                child: Center(
                  child: Text("No Transactions Found"),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                    child: CustomList(
                        list: transactions,
                        itemSpace: 20,
                        child: (Payment data, index) {
                          return _settlementList(context, data);
                        })),
              ),
      ],
    );
  }

  Widget _listItem(BuildContext context, Payment data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            boldText(data.name!, color: Colors.grey.shade500, fontSize: 20.0),
            const SizedBox(height: 5),
            Row(
              children: [
                Row(
                  children: [
                    boldText(data.date!,
                        color: Colors.grey.shade500, fontSize: 16.0),
                    const SizedBox(width: 5),
                    boldText(
                      data.time!,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ],
            ),
          ]),
          Row(
            children: [
              boldText(
                '₹ ${data.amount!}',
                color: Colors.grey.shade500,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _settlementList(BuildContext context, Payment data) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                semiBoldText('Batch Id: 4600074',
                    color: Colors.grey.shade500, fontSize: 18.0),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'JDE Status: ',
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                              fontFamily: FontFamilyHelper.sourceSansSemiBold)),
                      const TextSpan(
                        text: 'Success',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontFamily: FontFamilyHelper.sourceSansSemiBold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        semiBoldText(data.date!,
                            color: Colors.grey.shade500, fontSize: 18.0),
                        const SizedBox(width: 5),
                        semiBoldText(data.time!,
                            color: Colors.grey.shade500, fontSize: 18.0),
                      ],
                    ),
                  ],
                ),
              ]),
              Row(
                children: [
                  semiBoldText('₹ ${data.amount!}',
                      color: Colors.grey.shade500, fontSize: 18.0),
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
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 15),
        child: semiBoldText(pageIndex == 1 ? "Settlements" : 'Complete Details',
            color: Colors.black, fontSize: 19),
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
