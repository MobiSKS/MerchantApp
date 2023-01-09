// ignore_for_file: use_build_context_synchronously
import 'package:dtplusmerchant/Screens/financials/transaction_summary_detail.dart';
import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/transaction_slip.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../provider/financials_provider.dart';
import '../../util/utils.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final TextEditingController _tDSearchController = TextEditingController();
  final transDdata1 = ValueNotifier<List<Data>>([]);
  List<Data> transDdata = [];
  DateTime selectedDate = DateTime.now();
  String _selectedType = "";

  final TextEditingController _terminalIdController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
  final TextEditingController _toDateController = TextEditingController(
      text: Utils.convertDateFormatInDDMMYY(DateTime.now()));
  List<String> terminalIdList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: normalAppBar(context, title: AppStrings.transactionDetails),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          searchWidget(context, _tDSearchController,
              hintText: 'Search Card Number',
              onTap: showSearchFilter,
              onChanged: onChanged),
          const SizedBox(height: 15),
          Expanded(
            child: BaseView<FinancialsProvider>(onModelReady: (model) async {
              await model.getTransactionType(context);
              await model.getTransactionSlip(context);
            }, builder: (context, financeViewM, child) {
              transDdata =
                  financeViewM.isLoading || financeViewM.transactionSlip == null
                      ? []
                      : financeViewM.transactionSlip!.data!;
              transDdata1.value = transDdata;
              return financeViewM.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight(context) * 0.30),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : financeViewM.transactionSlip != null
                      ? SingleChildScrollView(child: _transactionDetail())
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
    if (_tDSearchController.text.isNotEmpty) {
      transDdata1.value = transDdata
          .where((e) => e.cardNo!
              .toUpperCase()
              .contains(_tDSearchController.text.toUpperCase()))
          .toList();
      _transactionDetail();
    } else {
      transDdata1.value = transDdata;
    }
  }

  Widget _transactionDetail() {
    return ValueListenableBuilder(
        valueListenable: transDdata1,
        builder: (_, value, __) => transDdata1.value.isEmpty
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
        showTransactionDetail(data);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth(context) * 0.03),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                semiBoldText('Card no: ${Utils.checkNullValue(data.cardNo!)}',
                    color: Colors.black, fontSize: 18.0),
                const SizedBox(height: 5),
                semiBoldText('TID : ${Utils.checkNullValue(data.terminalId!)}',
                    color: Colors.grey.shade500, fontSize: 18.0),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        semiBoldText(
                          Utils.checkNullValue(data.invoiceDate!.toString()),
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
                '₹ ${data.amount!}0',
                color: Colors.grey.shade800,
              ),
              const SizedBox(width: 8)
            ],
          )
        ],
      ),
    );
  }

  Future<void> showTransactionDetail(Data data) async {
    var prov = Provider.of<FinancialsProvider>(context, listen: false);

    await prov.getTransactionDetail(context,
        txnId: data.referenceNo, terminalId: data.terminalId);
    if (prov.transactionDetailModel != null &&
        prov.transactionDetailModel!.internelStatusCode == 1000) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionSummarydetail(
                  transDetail: prov.transactionDetailModel!,
                )),
      );
    }
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
             //  height: screenHeight(context) * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: _searchFilter()),
                ],
              ),
            );
          }));
        });
  }

  Widget _searchFilter() {
    FinancialsProvider financialPro =
        Provider.of<FinancialsProvider>(context, listen: false);
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
          _selectTerminalId(context, financialPro),
          // simpleTextField(
          //     context, _terminalIdController, "Terminal Id (Optional) "),
          SizedBox(height: screenHeight(context) * 0.01),
          _selectTransactionType(context, financialPro),
          SizedBox(height: screenHeight(context) * 0.06),
          customButton(context, AppStrings.search, onTap: () {
            getTransFilterData();
          })
        ],
      ),
    );
  }

  Future<void> getTransFilterData() async {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");

    FinancialsProvider fPro =
        Provider.of<FinancialsProvider>(context, listen: false);
    if (_fromDateController.text.isNotEmpty &&
        _toDateController.text.isNotEmpty) {
      if (dateFormat
              .parse(_fromDateController.text)
              .compareTo(dateFormat.parse(_toDateController.text)) >
          0) {
        alertPopUp(context, 'Please enter To Date greater than From date');
      } else {
        showLoader(context);
        await fPro.getTransactionSlip(context,
            fromDate: Utils.convertDateFormatInYYMMDD(
                dateS: _fromDateController.text),
            toDate:
                Utils.convertDateFormatInYYMMDD(dateS: _toDateController.text),
            transType: _selectedType,
            terminalId: _terminalIdController.text);
        dismissLoader(context);

        if (fPro.transactionDetailModel != null &&
            fPro.transactionDetailModel!.internelStatusCode == 1000) {
          _tDSearchController.clear();
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      }
    } else {
      transDdata1.value = [];
      alertPopUp(context, 'Please enter from and to date');
    }
  }

  Widget _selectTransactionType(
      BuildContext context, FinancialsProvider financialPro) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      height: 45,
      child: Center(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              enabledBorder: InputBorder.none, enabled: false),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          hint: semiBoldText('Select Transaction Type',
              color: Colors.grey.shade700, fontSize: 18),
          value: _selectedType.isEmpty ? null : _selectedType,
          items: financialPro.transactionType!.data!.map((value) {
            return DropdownMenuItem(
              value: value.transactionID.toString(),
              child: Text(value.transactionType!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedType = value!;
            });
          },
        ),
      ),
    );
  }

  Widget _selectTerminalId(
      BuildContext context, FinancialsProvider financialPro) {
    addterminalId(financialPro);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      height: 45,
      child: Center(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              enabledBorder: InputBorder.none, enabled: false),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          hint: semiBoldText('Select Terminal Id',
              color: Colors.grey.shade700, fontSize: 18),
          value: _terminalIdController.text.isEmpty
              ? null
              : _terminalIdController.text,
          items: terminalIdList.toSet().toList().map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _terminalIdController.text = value!;
            });
          },
        ),
      ),
    );
  }

  addterminalId(FinancialsProvider financialPro) {
    if (financialPro.transactionSlip != null) {
      for (int i = 0; i < financialPro.transactionSlip!.data!.length; i++) {
        terminalIdList.add(financialPro.transactionSlip!.data![i].terminalId!);
      }
    }
  }
}
