import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/common/slide_button.dart';
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
  String? _selectedValueSettlement;
  final List<Payment> transactions = [
    Payment(
        name: 'Ram Kumar',
        amount: '520',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:00 AM'),
    Payment(
        name: 'John Cena',
        amount: '678',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:55 AM'),
    Payment(
        name: 'Ram Kumar',
        amount: '520',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:00 AM'),
    Payment(
        name: 'John Cena',
        amount: '678',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:55 AM'),
    Payment(
        name: 'Ram Kumar',
        amount: '520',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:00 AM'),
    Payment(
        name: 'John Cena',
        amount: '678',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:55 AM'),
           Payment(
        name: 'Shyam Kumar',
        amount: '520',
        date: '13 JUL 2022',
        payMode: 'GPay',
        time: '10:00 AM'),
    Payment(
        name: 'Rohan Singh',
        amount: '78',
        date: '13 JUL 2022',
        payMode: 'GPay',
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
        backgroundColor: Colors.indigo.shade50,
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
        children: [_paymentWidget(context), _paymentWidget(context)],
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
                  headerText("Payment Trends",
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  headerText("No of Transactions",
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  const Spacer(),
                  headerText("Total",
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  headerText('50',
                      color: Colors.black, fontWeight: FontWeight.bold),
                  const Spacer(),
                  headerText("₹ 20,979",
                      color: Colors.black, fontWeight: FontWeight.bold),
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
            ? Padding(
                padding: const EdgeInsets.all(38.0),
                child: Container(
                  child: const Center(
                    child: Text("No Transactions Found"),
                  ),
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

  Widget _listItem(
    BuildContext context,
    Payment data,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            headerText(data.name!,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            const SizedBox(height: 5),
            Row(
              children: [
                Row(
                  children: [
                    headerText(data.date!,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                    const SizedBox(width: 5),
                    headerText(data.time!,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ],
            ),
          ]),
          Row(
            children: [
              headerText('₹ ${data.amount!}',
                  color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              const SizedBox(width: 20),
              headerText(data.payMode!,
                  color: Colors.grey.shade500, fontWeight: FontWeight.bold),
            ],
          )
        ],
      ),
    );
  }

  Widget _searchResultBar(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.055,
      color: Colors.indigo.shade200,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 15),
        child: headerText('Complete Details',
            color: Colors.black, fontWeight: FontWeight.w500),
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
