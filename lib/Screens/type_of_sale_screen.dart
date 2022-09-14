import 'package:dtplusmerchant/Screens/Sale-Reload/payment_acceptance.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../const/image_resources.dart';
import '../util/uiutil.dart';

class TypeOfSale extends StatefulWidget {
  const TypeOfSale({super.key});

  @override
  State<TypeOfSale> createState() => _TypeOfSaleState();
}

class _TypeOfSaleState extends State<TypeOfSale> {
  late String _payType;
  late String _selectedbank;
  late bool _otpSent;
  final List<String> _bankList = ['SBI', 'ICICI', 'HDFC'];
  final List<String> _payTypeList = [AppStrings.fastTag, AppStrings.ccms];
  final _mobileController = TextEditingController();
  final paymentOtpController = OtpFieldController();
  final _timerController = CountdownController();

  @override
  void initState() {
    super.initState();
    _payType = "";
    _selectedbank = "";
    _otpSent = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                SizedBox(height: screenHeight(context) * 0.02),
                _title(context),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight(context) * 0.05),
                        headerText(AppStrings.selectPaymentType,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500),
                        _selectPaymentType(context),
                        _payType == AppStrings.fastTag
                            ? _selectBank(context)
                            : Container(),
                        SizedBox(height: screenHeight(context) * 0.05),
                        headerText(AppStrings.mobileNum,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500),
                        _enterMobileNo(context),
                        _otpSent ? enterOTP(context) : Container(),
                        SizedBox(height: screenHeight(context) * 0.15),
                        customButton(context,
                            _otpSent ? AppStrings.submit : AppStrings.sendOTP,
                            onTap: !_otpSent ? _sendOTP : _submitFastTag)
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  void _submitFastTag() {
    Navigator.pushNamed(context, "/paymentAcceptance");
  }

  void _sendOTP() {
    if (_payType.isNotEmpty && _mobileController.text.isNotEmpty) {
      setState(() {
        _otpSent = true;
      });
    }
  }

  Widget enterOTP(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.07),
        headerText(AppStrings.enterOTP,
            color: Colors.grey.shade600, fontWeight: FontWeight.w500),
        otpTextField(context, paymentOtpController,
            color: Colors.grey.shade600),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            underlinedText(AppStrings.resendOTP, color: Colors.grey.shade500),
            Row(
              children: [
                smallText(AppStrings.resendOTPIn, color: Colors.grey.shade500),
                const SizedBox(width: 10),
                countDownTimer(context, 30, _timerController, color: Colors.red)
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _selectBank(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.04),
        headerText(AppStrings.selectBank,
            color: Colors.grey.shade600, fontWeight: FontWeight.w500),
        _selectBankList(context),
      ],
    );
  }

  Widget _enterMobileNo(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        controller: _mobileController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter 10 digit mobile Number',
        ),
      ),
    );
  }

  Widget _selectPaymentType(BuildContext context) {
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
          hint: const Text(AppStrings.selectPAYType),
          value: _payType.isEmpty ? null : _payType,
          items: _payTypeList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _payType = value!;
              _mobileController.clear();
              _otpSent = false;
            });
          },
        ),
      ),
    );
  }

  Widget _selectBankList(BuildContext context) {
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
          hint: const Text('Select Bank'),
          value: _selectedbank.isEmpty ? null : _selectedbank,
          items: _bankList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedbank = value!;
              _mobileController.clear();
              _otpSent = false;
            });
          },
        ),
      ),
    );
  }

  Widget _title(context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.06,
      color: Colors.indigo.shade300,
      child: Center(
          child: headerText(AppStrings.typeOfSale,
              fontWeight: FontWeight.w500, color: Colors.black)),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 24)),
              SizedBox(width: screenWidth(context) * 0.06),
              Image.asset(ImageResources.driveTruckPlusImage,
                  height: screenHeight(context) * 0.032),
            ],
          ),
          Row(
            children: [
              Image.asset(ImageResources.hpLogo,
                  height: screenHeight(context) * 0.05),
            ],
          )
        ],
      ),
    );
  }
}
