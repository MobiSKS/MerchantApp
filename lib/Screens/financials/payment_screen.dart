import 'package:dtplusmerchant/Screens/financials/settlement_screen.dart';
import 'package:flutter/material.dart';

import '../../common/custom_list.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> dropdownValues = ["Today", "Yesterday", "Last 7 Days"];
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
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 10),
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
                      hint: semiBoldText(_selectedValuePayment ?? "Today",
                          color: Colors.grey.shade700, fontSize: 22),
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
                    semiBoldText("Payment Trends",
                        color: Colors.grey.shade700, fontSize: 22),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(indent: 0, endIndent: 0, color: Colors.grey.shade600),
                const SizedBox(height: 5),
                Row(
                  children: [
                    semiBoldText("No of Transactions",
                        color: Colors.grey.shade700, fontSize: 22),
                    const Spacer(),
                    semiBoldText("Total",
                        color: Colors.grey.shade700, fontSize: 22),
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
                        itemSpace: 5,
                        child: (Payment data, index) {
                          return Column(
                            children: [
                              _listItem(context, data),
                              const SizedBox(height: 10),
                              Divider(
                                color: Colors.grey.shade700,
                                endIndent: 20,
                                indent: 20,
                              )
                            ],
                          );
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Utils.getRamdomColor(),
                child: Center(
                    child: semiBoldText(Utils.getNameInitials(data.name),
                        color: Colors.white, fontSize: 20)),
              ),
              SizedBox(width: screenWidth(context) * 0.03),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                semiBoldText(data.name!,
                    color: Colors.grey.shade800, fontSize: 20.0),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        semiBoldText(
                          data.date!,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 5),
                        semiBoldText(
                          data.time!,
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
              boldText(
                '₹ ${data.amount!}',
                color: Colors.grey.shade800,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: semiBoldText(
                 "Complete Details",
                color: Colors.black,
                fontSize: 19),
          ),
        ],
      ),
    );
  }
}