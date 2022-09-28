import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../base/base_view.dart';
import '../../util/uiutil.dart';
import 'auth_view_model.dart';

class ForgotPassword extends StatefulWidget {
 final bool isChangePassword;
  const ForgotPassword({
    super.key,
    this.isChangePassword = false,
  });
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpFieldController _otpController = OtpFieldController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _countDownController = CountdownController();
  bool _otpSent = false;
  final _monbileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundImage(context),
              _body(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BaseView<AuthViewModel>(builder: (context, auth, child) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: screenHeight(context) * 0.07),
            hpLogo(context),
            SizedBox(height: screenHeight(context) * 0.04),
            driverTruckTextImage(context),
            SizedBox(height: screenHeight(context) * 0.07),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: (_otpSent || widget.isChangePassword)
                  ? _forgetPasswordForm(context)
                  : mobileTextField(
                      context, _monbileController, AppStrings.enterMobileNo,
                      prefixIcon: false,
                      valMessage: AppStrings.enterMobileNoErrorMsg),
            ),
            SizedBox(height: screenHeight(context) * 0.10),
            customButton(context, AppStrings.submit, onTap: () {
              sendOTP(auth);
            }),
          ],
        ),
      );
    });
  }

  void sendOTP(AuthViewModel authViewM) async {}

  Widget _forgetPasswordForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(AppStrings.newPassword,
            color: Colors.indigo.shade900,
            fontSize: 23),
        SizedBox(height: screenHeight(context) * 0.02),
        normalText(AppStrings.enterOTPforNewPassword,
            color: Colors.white, textAlign: TextAlign.start, fontSize: 15.0),
        SizedBox(height: screenHeight(context) * 0.02),
        otpTextField(context, _otpController),
        SizedBox(height: screenHeight(context) * 0.03),
        _resendOTP(context),
        SizedBox(height: screenHeight(context) * 0.03),
        customTextField(context, _newPassword, AppStrings.newPassword,
            prefixIcon: false, valMessage: AppStrings.newPasswordError),
        SizedBox(height: screenHeight(context) * 0.03),
        customTextField(context, _confirmPassword, AppStrings.confirmPaasword,
            prefixIcon: false, valMessage: AppStrings.confirmPassError),
      ],
    );
  }

  Widget _resendOTP(BuildContext conmtext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                _countDownController.start();
              });
            },
            child:
                normalText(AppStrings.resendOTP, color: Colors.red, fontSize: 13.0)),
        Row(
          children: [
            normalText(AppStrings.resendOTPIn, color: Colors.white, fontSize: 13.0),
            const SizedBox(width: 5),
            countDownTimer(context, 30, _countDownController)
          ],
        ),
      ],
    );
  }
}
