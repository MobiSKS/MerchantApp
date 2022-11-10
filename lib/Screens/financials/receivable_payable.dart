// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/receivable_payable_model.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../util/font_family_helper.dart';
import '../../util/utils.dart';

class ReceivablePayable extends StatefulWidget {
  const ReceivablePayable({super.key});

  @override
  State<ReceivablePayable> createState() => _ReceivablePayableState();
}

class _ReceivablePayableState extends State<ReceivablePayable> {
  DateTime selectedDate = DateTime.now();
  final rcvPayList1 = ValueNotifier<List<Data>>([]);
  List<Data> rcvPayList = [];
  final TextEditingController _rcvPaySearchController = TextEditingController();
  final TextEditingController _terminalController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController(text:Utils.convertDateFormatInYYMMDD(DateTime.now()));
  final TextEditingController _toDateController = TextEditingController(text:Utils.convertDateFormatInYYMMDD(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: normalAppBar(context, title: AppStrings.receivablePayableDetail),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          searchWidget(context, _rcvPaySearchController,
              hintText: 'Search Transaction', onTap: showSearchFilter, onChanged: () {}),
          const SizedBox(height: 15),
          Expanded(
            child: BaseView<FinancialsProvider>(onModelReady: (model) async {
              await model.receivablePayableDetails(context);
            }, builder: (context, financeViewM, child) {
              rcvPayList = financeViewM.isLoading ||
                      financeViewM.receivablePayableResponseModel == null
                  ? []
                  : financeViewM.receivablePayableResponseModel!.data!;
              rcvPayList1.value = rcvPayList;
              return financeViewM.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight(context) * 0.30),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : financeViewM.receivablePayableResponseModel != null
                      ? SingleChildScrollView(child: _rcvPayableData())
                      : Column(
                          children: [
                            SizedBox(height: screenHeight(context) * 0.30),
                            semiBoldText('No Data found'),
                          ],
                        );
            }),
          ),
        ],
      ),
    );
  }

   void onChanged() {
    if (_rcvPaySearchController.text.isNotEmpty) {
      rcvPayList1.value = rcvPayList
          .where(
              (e) => e.batchId.toString() == _rcvPaySearchController.text)
          .toList();
      _rcvPayableData();
    } else {
      rcvPayList1.value = rcvPayList ;
    }
  }

  Widget _rcvPayableData() {
    return ValueListenableBuilder(
        valueListenable: rcvPayList1,
        builder: (_, value, __) => rcvPayList1.value.isEmpty
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
                                onTap: () {},
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
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiBoldText('Batch Id:',
                color: Colors.grey.shade900, fontSize: 18.0),
            semiBoldText(data.batchId!.toString(),
                color: Colors.grey.shade600, fontSize: 18.0),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiBoldText('Terminal Id',
                color: Colors.grey.shade900, fontSize: 18.0),
            semiBoldText(data.terminalId!,
                color: Colors.grey.shade600, fontSize: 18.0),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiBoldText('Payable Amount : ',
                color: Colors.grey.shade900, fontSize: 18.0),
            semiBoldText('₹ ${data.receivable}',
                color: Colors.grey.shade600, fontSize: 18.0),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiBoldText('Receivable Amount : ',
                color: Colors.grey.shade900, fontSize: 18.0),
            semiBoldText('₹ ${data.receivable}',
                color: Colors.grey.shade600, fontSize: 18.0),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            semiBoldText('Settlement Date : ',
                color: Colors.grey.shade900, fontSize: 18.0),
            semiBoldText(' ${data.settlementDate!}',
                color: Colors.grey.shade600, fontSize: 18.0),
          ],
        ),
      ]),
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: _searchFilter()),
                ],
              ),
            );
          }));
        });
  }
  

  Widget _searchFilter() {
    var financialPro = Provider.of<FinancialsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight(context) * 0.02),
             semiBoldText('From Date',color: Colors.grey.shade700,fontSize: 18),
          GestureDetector(
            onTap: () {
              Utils.selectDatePopup(context, selectedDate, _fromDateController);
            },
            child: dateTextField(context, _fromDateController, 'From Date',
                showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.01),
             semiBoldText('To Date',color: Colors.grey.shade700,fontSize: 18),
          GestureDetector(
            onTap: () =>
                Utils.selectDatePopup(context, selectedDate, _toDateController),
            child: dateTextField(context, _toDateController, 'To Date',
                showIcon: true, enabled: false),
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(
              context, _terminalController, "Terminal ID (optional)"),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.search, onTap: ()  {
            getFilterData(financialPro);
      
          })
        ],
      ),
    );
  }

  void getFilterData(FinancialsProvider fPro)async{
        if (_fromDateController.text.isNotEmpty &&
        _toDateController.text.isNotEmpty) {
      showLoader(context);
      await fPro.receivablePayableDetails(context,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          terminalId: _terminalController.text
          );
      dismissLoader(context);

      if (fPro.transactionDetailModel != null &&
          fPro.transactionDetailModel!.internelStatusCode == 1000) {
        _rcvPaySearchController.clear();
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else {
      alertPopUp(context, 'Please enter from and to date');
    }
  }
}
