// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/Screens/transactions/paycode_receipt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../provider/transactions_provider.dart';
import '../../util/font_family_helper.dart';
import '../../util/uiutil.dart';

class PayMerchant extends StatefulWidget {
  const PayMerchant({super.key});

  @override
  State<PayMerchant> createState() => _PayMerchantState();
}

class _PayMerchantState extends State<PayMerchant> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _payCodeController = TextEditingController();
  late String selectedMode;
  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
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
    return SafeArea(
      child: Scaffold(
          appBar: normalAppBar(context, title: AppStrings.payMerchant),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight(context) * 0.05),
                        _enterpayCode(context),
                        SizedBox(height: screenHeight(context) * 0.10),
                        customButton(context, AppStrings.submit, onTap: () {
                          submitOTPSale();
                        }),
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Future<void> submitOTPSale() async {
    if (_validate()) {
      var transactionPro =
          Provider.of<TransactionsProvider>(context, listen: false);
      await transactionPro.payByPaycode(
        context,
        payCode: _payCodeController.text,
      );
      if (transactionPro.paycodeResponseModel!.internelStatusCode == 1000) {
        showToast('Payment Successfull', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PayCodeReceipt(
                    payCodeResp: transactionPro.paycodeResponseModel!,
                  )),
        );
      }
    }
  }

  void _requestFocus(FocusNode focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  Widget _enterpayCode(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: Form(
        key: _formKey,
        child: TextFormField(
          onTap: () {
            _requestFocus(myFocusNode);
          },
          focusNode: myFocusNode,
          controller: _payCodeController,
          validator: (val) => val!.isEmpty ? 'Please enter Paycode' : null,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'Enter Pay Code',
              labelStyle: TextStyle(
                  fontFamily: FontFamilyHelper.sourceSansSemiBold,
                  fontSize:
                      myFocusNode.hasFocus || _payCodeController.text.isNotEmpty
                          ? 23
                          : 18,
                  color: myFocusNode.hasFocus
                      ? Colors.grey.shade700
                      : Colors.grey.shade700)),
        ),
      ),
    );
  }
}
