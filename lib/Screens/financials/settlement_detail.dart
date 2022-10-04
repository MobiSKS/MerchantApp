import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:flutter/material.dart';
import '../../util/uiutil.dart';

class SettlementDetail extends StatefulWidget {
  const SettlementDetail({super.key});
  @override
  State<SettlementDetail> createState() => _SettlementDetailState();
}

class _SettlementDetailState extends State<SettlementDetail> {
  double columnPadding = 20;
  final List<Payment> transactions = [
    Payment(
        name: 'Ram Kumar', amount: '520', date: '8-Sep-2022', time: '10:00 AM'),
    Payment(
        name: 'John Cena', amount: '678', date: '8-Sep-2022', time: '10:55 AM'),
    Payment(
        name: 'Ram Kumar', amount: '520', date: '8-Sep-2022', time: '10:00 AM'),
    Payment(
        name: 'John Cena', amount: '678', date: '8-Sep-2022', time: '10:55 AM'),
    Payment(
        name: 'Ram Kumar', amount: '520', date: '8-Sep-2022', time: '10:00 AM'),
    Payment(
        name: 'John Cena', amount: '678', date: '8-Sep-2022', time: '10:55 AM'),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: normalAppBar(context, title: 'Settlement Detail'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(child: _body(context)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context) * 0.03),
        _settlementWidget(context),
      ],
    );
  }

  Widget _settlementWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              semiBoldText("Summary",
                  color: Colors.grey.shade700, fontSize: 20),
              const SizedBox(height: 10),
              semiBoldText("No. of Transactions : 05",
                  color: Colors.grey.shade700, fontSize: 20),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  semiBoldText("Settlement on: 08-Sep-2022",
                      color: Colors.grey.shade700, fontSize: 20),
                  Row(
                    children: [
                      shareButton(),
                      SizedBox(width: MediaQuery.of(context).size.width * .04),
                      downloadButton()
                    ],
                  )
                ],
              ),
              SizedBox(height: screenHeight(context) * 0.03),
            ],
          ),
        ),
        Column(
          children: [
            _searchResultBar(context),
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
            : SizedBox(
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

  Widget _listItem(BuildContext context, Payment data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            semiBoldText(data.name!,
                color: Colors.grey.shade500, fontSize: 18.0),
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

  Widget _searchResultBar(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.055,
      color: Colors.indigo.shade100,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 15),
        child: semiBoldText("Transactions", color: Colors.black, fontSize: 19),
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
