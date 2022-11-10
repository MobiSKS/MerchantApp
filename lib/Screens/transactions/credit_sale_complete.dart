// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:dtplusmerchant/Screens/transactions/credit_complete_receipt.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../provider/transactions_provider.dart';
import '../../util/uiutil.dart';

class CreditSaleComplete extends StatefulWidget {
  const CreditSaleComplete({super.key});

  @override
  State<CreditSaleComplete> createState() => _CreditSaleComplete();
}

class _CreditSaleComplete extends State<CreditSaleComplete> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool otpReceived = false;
  final _cardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _otpController = OtpFieldController();
  String? otp;
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
          appBar: normalAppBar(context, title: AppStrings.creditSaleComplete),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
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
                          _enterCardNumber(context),
                          SizedBox(height: screenHeight(context) * 0.04),
                          _enterAmount(context),
                          otpReceived ? enterOTP(context) : Container(),
                          SizedBox(height: screenHeight(context) * 0.10),
                          customButton(context, AppStrings.submit, onTap: () {
                            submit();
                          }),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }

  Widget enterOTP(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.07),
        boldText(
          AppStrings.enterOTP,
          color: Colors.grey.shade600,
        ),
        _otpTextField(context, _otpController, color: Colors.grey.shade600),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _otpTextField(
    BuildContext context,
    OtpFieldController controller, {
    Color color = Colors.white,
  }) {
    return OTPTextField(
      controller: controller,
      length: 6,
      width: screenWidth(context),
      fieldWidth: 50,
      style: TextStyle(fontSize: 18, color: color),
      textFieldAlignment: MainAxisAlignment.spaceBetween,
      fieldStyle: FieldStyle.underline,
      keyboardType: TextInputType.number,
      otpFieldStyle: OtpFieldStyle(
          enabledBorderColor: color, disabledBorderColor: color //(here)
          ),
      onCompleted: (pin) {
        setState(() {
          otp = pin;
        });
      },
      onChanged: (pin) {
        if (pin.length != 6) {
          setState(() {});
        }
      },
    );
  }

  Future<void> submit() async {
    otpReceived ? submitOTP() : receiveOTP();
  }

  Future<void> receiveOTP() async {
    var transactionPro =
        Provider.of<TransactionsProvider>(context, listen: false);
    if (_validate()) {
      await transactionPro.generateOTPSale(
        context,
        ccn: _cardNumberController.text,
        invoiceAmount: double.parse(_amountController.text),
        otpType: Utils.otpTypeForCreditSaleComplete,
      );
      if (transactionPro.otpResponseSale!.internelStatusCode == 1000) {
        log('===>otp ${transactionPro.otpResponseSale!.data![0].oTP!}');
        showToast(transactionPro.otpResponseSale!.data![0].oTP!, false);
        setState(() {
          otpReceived = true;
        });
      }
    }
  }

  Future<void> submitOTP() async {
    var transactionPro =
        Provider.of<TransactionsProvider>(context, listen: false);
    if (_validate()) {
      await transactionPro.saleByTerminal(
        context,
        otp: otp,
        cardNum: _cardNumberController.text,
        formFactor: 4,
        transType: 522,
        invoiceAmount: double.parse(_amountController.text),
      );
      if (transactionPro.saleByTeminalResponse!.internelStatusCode == 1000) {
        showToast('Payment Successfull', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CreditCompleteReceipt(
                    creditCompResp: transactionPro.saleByTeminalResponse!,
                  )),
        );
      } else {
        setState(() {
          otpReceived = false;
        });
      }
    }
  }

  void _requestFocus(FocusNode focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  FocusNode myFocusNode1 =  FocusNode();
  FocusNode myFocusNode2 =  FocusNode();
  Widget _enterCardNumber(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        onTap: () {
          _requestFocus(myFocusNode1);
        },
        focusNode: myFocusNode1,
        controller: _cardNumberController,
        validator: (val) => val!.isEmpty ? 'Please enter card number' : null,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            fontFamily: FontFamilyHelper.sourceSansRegular, fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter Card Number',
            labelStyle: TextStyle(
                fontFamily: FontFamilyHelper.sourceSansSemiBold,
                fontSize: myFocusNode1.hasFocus ||
                        _cardNumberController.text.isNotEmpty
                    ? 23
                    : 18,
                color: myFocusNode1.hasFocus
                    ? Colors.grey.shade700
                    : Colors.grey.shade700)),
      ),
    );
  }

  Widget _enterAmount(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        focusNode: myFocusNode2,
        onTap: () {
          _requestFocus(myFocusNode2);
        },
        controller: _amountController,
        style: const TextStyle(
            fontFamily: FontFamilyHelper.sourceSansRegular, fontSize: 18),
        validator: (val) => val!.isEmpty ? 'Please enter amount' : null,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Enter Amount',
            labelStyle: TextStyle(
                fontFamily: FontFamilyHelper.sourceSansSemiBold,
                fontSize:
                    myFocusNode2.hasFocus || _amountController.text.isNotEmpty
                        ? 23
                        : 18,
                color: myFocusNode2.hasFocus
                    ? Colors.grey.shade700
                    : Colors.grey.shade700)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode1.dispose();
    myFocusNode2.dispose();
  }
}
