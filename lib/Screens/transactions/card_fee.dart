import 'dart:ffi';

import 'package:dtplusmerchant/model/card_fee_response_model.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../provider/transactions_provider.dart';
import '../../util/uiutil.dart';
import 'card_fee_receipt.dart';

class CardFee extends StatefulWidget {
  const CardFee({super.key});
  @override
  State<CardFee> createState() => _CardFeeState();
}

class _CardFeeState extends State<CardFee> {
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  DateTime selectedDate = DateTime.now();
  FocusNode focus1 = FocusNode();
  final TextEditingController _formNoController = TextEditingController();
  bool showdata = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: normalAppBar(context, title: AppStrings.cardFee),
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _searchFilter(),
        SizedBox(height: screenHeight(context) * 0.03),
      ],
    );
  }

  void _requestFocus1() {
    setState(() {
      FocusScope.of(context).requestFocus(focus1);
    });
  }

  Widget _searchFilter() {
    return BaseView<TransactionsProvider>(builder: (context, transPro, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: screenHeight(context) * 0.04),
            simpleTextField(context, _formNoController, AppStrings.enterFormNo,
                focusNode: focus1, onClick: _requestFocus1),
            SizedBox(height: screenHeight(context) * 0.07),
            customButton(context, AppStrings.submit, onTap: () {
              submit();
            }),
            SizedBox(height: screenHeight(context) * 0.04),
          showdata?  _cardFeeWidget(transPro.cardFeeResponseModel):Container(),
          ],
        ),
      );
    });
  }

  Future<void> submit() async {
    var cardFeeProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    if (_formNoController.text.isNotEmpty) {
      await cardFeeProvider.cardFeePaynment(
        context,
        formNumber: int.parse(_formNoController.text).toUnsigned(64),
      );
      if (cardFeeProvider.cardFeeResponseModel != null &&
          cardFeeProvider.cardFeeResponseModel!.internelStatusCode == 1000) {
            setState(() {
              showdata= true;
            });
          }
    } else {
      alertPopUp(context, 'Please enter form number');
    }
  }

  Widget _cardFeeWidget(CardFeeResponseModel? cardFee) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          width: screenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
          
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          semiBoldText(AppStrings.formNo,
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontFamily: FontFamilyHelper.sourceSansRegular),
                          semiBoldText(_formNoController.text,
                              color: Colors.black, fontSize: 16),
                        ],
                      ),
                      SizedBox(width: screenWidth(context) * 0.10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          semiBoldText(AppStrings.numberOfCards,
                              color: Colors.black, textAlign: TextAlign.start),
                                semiBoldText(cardFee!.data!.first.noofCards!.toString(),
                              color: Colors.black, textAlign: TextAlign.start),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      semiBoldText('Amount',
                          color: Colors.black, textAlign: TextAlign.start),
                      boldText(
                        cardFee.data!.first.amount!.toString(),
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  SizedBox(height: screenHeight(context) * 0.01),
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }

  Widget _footerWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.indigo.shade300,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
    );
  }
}
