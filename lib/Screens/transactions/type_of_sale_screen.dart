// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dtplusmerchant/Screens/transactions/sale_receipt.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/provider/sale_reload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../base/base_view.dart';
import '../../const/image_resources.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';

class TypeOfSale extends StatefulWidget {
  final String? amount;
  final int? productId;
  const TypeOfSale({super.key, this.amount, this.productId});

  @override
  State<TypeOfSale> createState() => _TypeOfSaleState();
}

class _TypeOfSaleState extends State<TypeOfSale> {
  final _sharedPref = Injection.injector.get<SharedPref>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _payType;
 late String transType;
  late String _selectedbank;
  late bool _otpSent;
  String otp = "";
  int bankId = 0;
  final _mobileController = TextEditingController();
  final _vehicleNoController = TextEditingController();
  final paymentOtpController = OtpFieldController();
  final _timerController = CountdownController();
  bool enabledButton = false;
  @override
  void initState() {
    super.initState();
    _payType = "";
    _selectedbank = "";
    _otpSent = false;
  }

  bool validateMobile() {
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
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: BaseView<SaleReloadViewModel>(
              builder: (context, saleReloadViewM, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
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
                            _payType == '505'
                                ? _selectBank(context)
                                : Container(),
                            _payType == '505'
                                ? _enterVehicleNo(context)
                                : Container(),
                            SizedBox(height: screenHeight(context) * 0.05),
                            headerText(AppStrings.mobileNum,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500),
                            _enterMobileNo(context),
                            _otpSent ? enterOTP(context) : Container(),
                            SizedBox(height: screenHeight(context) * 0.15),
                            sendOTPButton(context, saleReloadViewM)
                          ],
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget sendOTPButton(
      BuildContext context, SaleReloadViewModel saleReloadViewM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context) * 0.05,
        child: TextButton(
          onPressed: () {
            !_otpSent
                ? sendOTP(saleReloadViewM)
                : enabledButton
                    ? _submitPayment(saleReloadViewM)
                    : alertPopUp(context, 'Please enter otp');
          },
          style: buttonStyle,
          child: Text(
            _otpSent ? AppStrings.submit : AppStrings.sendOTP,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget enterOTP(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.07),
        headerText(AppStrings.enterOTP,
            color: Colors.grey.shade600, fontWeight: FontWeight.w500),
        _otpTextField(context, paymentOtpController,
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
          enabledButton = true;
          otp = pin;
        });
      },
      onChanged: (pin) {
        if (pin.length != 6) {
          setState(() {
            enabledButton = false;
          });
        }
      },
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
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter 10 digit mobile Number',
        ),
      ),
    );
  }

  Widget _enterVehicleNo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight(context) * 0.05),
        headerText('Vehicle Number',
            color: Colors.grey.shade600, fontWeight: FontWeight.w500),
        SizedBox(
          width: screenWidth(context),
          child: TextFormField(
            controller: _vehicleNoController,
            validator: (val) =>
                val!.isEmpty ? 'Please enter vehicle number' : null,
            decoration: const InputDecoration(
              hintText: 'Enter last 4 digit of vehicle number',
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectPaymentType(BuildContext context) {
    var paymentTypeList = _sharedPref.user!.data!.objGetParentTransTypeDetail!;
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
          items: paymentTypeList.map((value) {
            return DropdownMenuItem(
              value: value.transType.toString(),
              child: Text(value.transName!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _payType = value!;
              _mobileController.clear();
              _otpSent = false;
           transType =  paymentTypeList.where((e) => e.transType==int.parse(_payType)).toList()[0].transName!;
            });
          },
        ),
      ),
    );
  }

  Widget _selectBankList(BuildContext context) {
    var banklList = _sharedPref.user!.data!.objBanks;
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
          items: banklList!.map((value) {
            return DropdownMenuItem(
              value: value.fastagName,
              child: Text(value.fastagName!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedbank = value!.toString();
              bankId = banklList
                  .where((e) => e.fastagName == _selectedbank)
                  .toList()[0]
                  .fastagId!;
              log('==========>$bankId');
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

  Future<void> _submitPayment(SaleReloadViewModel saleReloadViewM) async {
    await saleReloadViewM.saleByTerminal(context,
        invoiceAmount: double.parse(widget.amount!),
        mobileNo: _mobileController.text,
        otp: otp,
        transType: int.parse(_payType),
        productId: widget.productId);
    if (saleReloadViewM.saleByTeminalResponse!.internelStatusCode == 1000) {
      showToast('Payment Successfull', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SaleReceipt(
                  saleResponse: saleReloadViewM.saleByTeminalResponse!,
                  mobileNo: _mobileController.text,
                  transType: transType,
                )),
      );
    } else {
      setState(() {
        _otpSent = false;
      });
    }
  }

  Future<void> sendOTP(SaleReloadViewModel saleReloadViewM) async {
    _payType == "505"
        ? await sendOTPforFastTag(saleReloadViewM)
        : await sendOTPforCCM(saleReloadViewM);
  }

  Future<void> sendOTPforCCM(SaleReloadViewModel saleReloadViewM) async {
    if (validateMobile() && _payType.isNotEmpty) {
      await saleReloadViewM.generateOTPSale(context,
          mobileNo: _mobileController.text,
          invoiceAmount: double.parse(widget.amount!),
          transType: int.parse(_payType));
      if (saleReloadViewM.otpResponseSale!.internelStatusCode == 1000) {
        log('===========> OTP ${saleReloadViewM.otpResponseSale!.data![0].oTP!}');
        showToast('OTP sent successfully', false);
        setState(() {
          _otpSent = true;
        });
      } else {
        alertPopUp(context, saleReloadViewM.otpResponseSale!.message!);
      }
    }
  }

  Future<void> sendOTPforFastTag(SaleReloadViewModel saleReloadViewM) async {
    if (validateMobile() && _payType.isNotEmpty) {
      await saleReloadViewM.generateOtpFastTAG(context,
          mobileNo: _mobileController.text,
          invoiceAmount: double.parse(widget.amount!),
          bankId: bankId,
          vehicleNo: _vehicleNoController.text);
      if (saleReloadViewM.fastTagOTPResponse!.internelStatusCode == 1000) {
        showToast('OTP sent successfully', false);
        setState(() {
          _otpSent = true;
        });
      } else {
        alertPopUp(context, saleReloadViewM.fastTagOTPResponse!.message!);
      }
    }
  }
}
