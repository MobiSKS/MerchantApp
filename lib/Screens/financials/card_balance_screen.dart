import 'dart:developer';

import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/model/card_enquiry_model.dart';
import 'package:dtplusmerchant/provider/transactions_provider.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../const/app_strings.dart';

class CardBalanceScreen extends StatefulWidget {
  const CardBalanceScreen({super.key});

  @override
  State<CardBalanceScreen> createState() => _CardBalanceScreenState();
}

class _CardBalanceScreenState extends State<CardBalanceScreen> {
  bool _otpReceived = false;
  final _mobileController = TextEditingController();
  final otpController = OtpFieldController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;

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
        appBar: normalAppBar(context, title: AppStrings.cardBalance),
        body: SingleChildScrollView(child: _body(context)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    var transactionPro =
        Provider.of<TransactionsProvider>(context, listen: false);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: screenHeight(context) * 0.03),
              semiBoldText('Mobile Number', color: Colors.grey.shade600),
              _enterMobileNo(context),
              _otpReceived ? enterOTP(context) : Container(),
              SizedBox(height: screenHeight(context) * 0.06),
              customButton(context, AppStrings.submit, onTap: () {
                submit();
              }),
            ]),
          ),
          _otpReceived
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.06,
                    color: Colors.indigo.shade200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: semiBoldText(
                            'Card Balance Detail',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: screenHeight(context) * 0.02),
          transactionPro.cardEnquiryResponseModel != null
              ? _cardBalanceDetail(
                  context, transactionPro.cardEnquiryResponseModel!.data![0])
              : Container(),
        ],
      ),
    );
  }

  Widget enterOTP(BuildContext context) {
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.07),
        semiBoldText(
          AppStrings.enterOTP,
          color: Colors.grey.shade600,
        ),
        _otpTextField(context, otpController, color: Colors.grey.shade600),
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
      length: 4,
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

  Widget _enterMobileNo(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        controller: _mobileController,
        validator: (val) {
          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(val!)) {
            return 'Enter Valid Phone Number';
          } else {
            return null;
          }
        },
        // onFieldSubmitted: submit(),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter mobile Number',
        ),
      ),
    );
  }

  Widget _cardBalanceDetail(
    BuildContext context,
    Data data,
  ) {
    List<CommonList> cardBalanceEntity = [
      CommonList(key: 'Date', value: '22/09/2022'),
      CommonList(key: 'Time', value: '2:10 PM'),
      CommonList(key: 'Monthly Limit', value: 'Rs ${data.monthlyLimit}'),
      CommonList(key: 'Monthly Spent', value: 'Rs ${data.monthlySpent}'),
      CommonList(
          key: 'Monthly Limit Balance', value: 'Rs ${data.monthlyLimitBal}'),
      CommonList(key: 'Daily Limit', value: 'Rs ${data.dailyLimit}'),
      CommonList(key: 'Daily Spent', value: 'Rs ${data.dailySpent}'),
      CommonList(key: 'Daily Limit Balance', value: 'Rs ${data.dailyLimitBal}'),
    ];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomList(
            list: cardBalanceEntity,
            //  itemSpace: 15,
            child: (CommonList data, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        semiBoldText(data.key!, color: Colors.black, fontSize: 18),
                        semiBoldText(data.value!,
                            color: Colors.blueGrey, fontSize: 18,)
                      ],
                    ),
                  ),
                  // const SizedBox(height: 15),
                  index != cardBalanceEntity.length - 1
                      ? const Divider(color: Colors.blueGrey)
                      : Container()
                ],
              );
            }));
  }

  Future<void> submit() async {
    var transactionPro =
        Provider.of<TransactionsProvider>(context, listen: false);

    if (!_otpReceived) {
      await transactionPro.generateOTPSale(
        context,
        mobileNo: _mobileController.text,
        otpType: Utils.otpTypeForCardBalanceEnquiry,
      );

      if (transactionPro.otpResponseSale!.internelStatusCode == 1000) {
        log('===>otp ${transactionPro.otpResponseSale!.data![0].oTP!}');
        showToast(transactionPro.otpResponseSale!.data![0].oTP!, false);
        setState(() {
          _otpReceived = true;
        });
      }
    } else {
      await transactionPro.cardEnquiryDetails(context,
          mobileNo: _mobileController.text, otp: otp,callBack: refreshCallBack);
      if (transactionPro.cardEnquiryResponseModel!.internelStatusCode == 1000) {
        debugPrint('===>otp ${transactionPro.cardEnquiryResponseModel!.data}');
        showToast(transactionPro.cardEnquiryResponseModel!.message!, false);
        setState(() {
          _otpReceived = false;
         
        });
      } else {}
    }
  }

  void refreshCallBack() {
    setState(() {
      _otpReceived = false;
      _mobileController.text = "";
    });
  }
}

class CommonList {
  String? key;
  String? value;

  CommonList({this.key, this.value});
}
