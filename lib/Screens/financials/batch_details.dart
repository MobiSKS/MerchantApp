import 'package:flutter/material.dart';
import '../../common/custom_list.dart';
import '../../const/app_strings.dart';
import '../../util/uiutil.dart';
import '../../util/utils.dart';

class BatchDetails extends StatefulWidget {
  const BatchDetails({super.key});

  @override
  State<BatchDetails> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {
  List<String> transactionList = ['1', '2', '3', '4'];
  DateTime selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _merchantController = TextEditingController();
  final TextEditingController _batchIdController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: normalAppBar(context, title: 'Earning Details'),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) { 
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: searchWidget(context, _searchController,
              hintText: 'Search Transaction',
              onTap: showSearchFilter,
              onChanged: () {}),
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _searchResults(),
        )),
      ],
    );
  }

  void showSearchFilter() {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: ((BuildContext context, StateSetter setState) {
            return SizedBox(
              // height: screenHeight(context) * 0.45,
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: _searchFilter()),
                ],
              ),
            );
          }));
        });
  }

  Widget _searchFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight(context) * 0.023),
          semiBoldText(
            'From Date',
            color: Colors.grey.shade700,
            fontSize: 18,
          ),
          GestureDetector(
            onTap: () => Utils.selectDatePopup(
                context, selectedDate, _fromDateController),
            child: dateTextField(context, _fromDateController, 'From Date',
                showLabel: false, showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.02),
          semiBoldText('To Date', color: Colors.grey.shade700, fontSize: 18),
          GestureDetector(
            onTap: () =>
                Utils.selectDatePopup(context, selectedDate, _toDateController),
            child: dateTextField(context, _toDateController, 'To Date',
                showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(context, _merchantController, "Merchnat Id"),
          SizedBox(height: screenHeight(context) * 0.01),
          SizedBox(height: screenHeight(context) * 0.06),
          customButton(context, AppStrings.search, onTap: () {})
        ],
      ),
    );
  }

  Widget _searchResults() {
    return CustomList(
      list: transactionList,
      itemSpace: 20,
      child: (String data, index) {
        return _batchDetailCard();
      },
    );
  }

  Widget _batchDetailCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          width: screenWidth(context),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  normalText(
                    'Customer Name : Rajnish Kumar',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  Row(
                    children: [
                      normalText(
                        'Transaction Type : Earning',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
              Divider(color: Colors.indigo.shade400),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText('Transaction Source',
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontSize: 17),
                          const SizedBox(height: 2),
                          semiBoldText(
                            'Dealer Contribution-Vas',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText('Slab(Paisa per ltr)',
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontSize: 17),
                          const SizedBox(height: 2),
                          semiBoldText(
                            '5.00',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText('Earning Amount',
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontSize: 17),
                          semiBoldText(
                            '0.05',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText('Sale Amount          ',
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontSize: 17),
                          semiBoldText(
                            '100.00',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                ],
              ),
            ],
          ),
        ),
        _transactionID()
      ],
    );
  }

  Widget _transactionID() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
      decoration: BoxDecoration(
          color: Colors.indigo.shade300,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          normalText('Customer ID: 4010000018',
              color: Colors.white, fontSize: 13),
          normalText('Transaction Date: 22/12/2022',
              color: Colors.white, fontSize: 13),
        ],
      ),
    );
  }
}
