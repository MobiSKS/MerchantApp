// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/app_strings.dart';
import '../../util/font_family_helper.dart';
import '../../util/uiutil.dart';
import 'gift_voucher_receipt.dart';

class GiftVoucherScreen extends StatefulWidget {
  const GiftVoucherScreen({super.key});

  @override
  State<GiftVoucherScreen> createState() => _GiftVoucherScreenState();
}

class _GiftVoucherScreenState extends State<GiftVoucherScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _giftVoucherController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();

  void _requestFocus(BuildContext context, FocusNode focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  bool _validate() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _giftVoucherWidget(context);
  }

  Widget _giftVoucherWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight(context) * 0.05),
                    _enterGiftVoucherCode(context),
                    SizedBox(height: screenHeight(context) * 0.02),
                    _enterAmount(context),
                    SizedBox(height: screenHeight(context) * 0.10),
                    customButton(context, AppStrings.submit, onTap: () {
                      submitGiftVoucher();
                    }),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> submitGiftVoucher() async {
    TransactionsProvider transPro =
        Provider.of<TransactionsProvider>(context, listen: false);
    if (_validate()) {
      await transPro.payByGiftVoucher(context,amount: double.parse(_amountController.text),voucherCode: _giftVoucherController.text);
      if(transPro.giftVoucherModel!.internelStatusCode==1000){
            Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GiftVoucherReceipt(
                    giftVoucher: transPro.giftVoucherModel!,
                    voucherNo: _giftVoucherController.text,
                  )),
        );

      }
      
    }
  }

  Widget _enterAmount(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        onTap: () {
          _requestFocus(context, myFocusNode);
        },
        focusNode: myFocusNode,
        controller: _amountController,
        validator: (val) => val!.isEmpty ? 'Please enter amount' : null,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Enter Amount',
            labelStyle: TextStyle(
                fontFamily: FontFamilyHelper.sourceSansSemiBold,
                fontSize: myFocusNode.hasFocus ||
                        _giftVoucherController.text.isNotEmpty
                    ? 23
                    : 18,
                color: myFocusNode.hasFocus
                    ? Colors.grey.shade700
                    : Colors.grey.shade700)),
      ),
    );
  }

  Widget _enterGiftVoucherCode(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        onTap: () {
          _requestFocus(context, myFocusNode1);
        },
        focusNode: myFocusNode1,
        controller: _giftVoucherController,
        validator: (val) => val!.isEmpty ? 'Please enter Gift Voucher' : null,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Enter Gift Voucher',
            labelStyle: TextStyle(
                fontFamily: FontFamilyHelper.sourceSansSemiBold,
                fontSize: myFocusNode1.hasFocus ||
                        _giftVoucherController.text.isNotEmpty
                    ? 23
                    : 18,
                color: myFocusNode1.hasFocus
                    ? Colors.grey.shade700
                    : Colors.grey.shade700)),
      ),
    );
  }
}
