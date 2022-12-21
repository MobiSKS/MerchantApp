// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
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
  final _userNameController = TextEditingController();
  bool _otpSent = false;
  final _emailController = TextEditingController();
  final OtpFieldController _otpController = OtpFieldController();
  String otp = "";

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
              child: Column(
                children: [
                  _fogetPassword(),
                  const SizedBox(height: 5),
                  _otpSent
                      ? _otpTextField(context, _otpController)
                      : Container()
                ],
              ),
            ),
            SizedBox(height: screenHeight(context) * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: customButton(context, AppStrings.submit, onTap: () {
                _otpSent ? verifyOTP(auth) : generateOTP(auth);
              }),
            ),
          ],
        ),
      );
    });
  }

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Widget _otpTextField(
    BuildContext context,
    OtpFieldController controller, {
    Color color = Colors.white,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        semiBoldText('Enter OTP',color:Colors.white),
      const  SizedBox(height:10),
        OTPTextField(
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
            setState(() {
              otp = pin;
            });
          },
        ),
      ],
    );
  }
  Widget _fogetPassword() {
    return Column(
      children: [
        customTextField(context, _userNameController, 'User Name',
            prefixIcon: false, valMessage: 'User Name is required*'),
        SizedBox(height: screenHeight(context) * 0.03),
        emailTextField(context, _emailController, 'Enter email Id',
            prefixIcon: false),
        SizedBox(height: screenHeight(context) * 0.03),
      ],
    );
  }

  Future<void> generateOTP(AuthViewModel authViewM) async {
    if (validateAndSave()) {
      await authViewM.forgetPasswordOTP(context,
          emailId: _emailController.text, userName: _userNameController.text);
      if (authViewM.forgetPasswordOTPModel!.internelStatusCode == 1000) {
        showToast('${authViewM.forgetPasswordOTPModel!.data![0].oTP}', false);
        alertPopUp(
          context,
          '${authViewM.forgetPasswordOTPModel!.data![0].reason}',
        );
        if (authViewM.forgetPasswordOTPModel!.data![0].oTP != null) {
          setState(() {
            _otpSent = true;
          });
        }
      }
    }
  }

  Future<void> verifyOTP(AuthViewModel authViewM) async {
    if (validateAndSave() && otp.length == 6) {
      await authViewM.forgetPasswordOTPVerify(
        context,
        emailId: _emailController.text,
        oTP: otp,
        userName: _userNameController.text,
      );

      if (authViewM.forgetOTPverify!.internelStatusCode == 1000) {
        alertPopUp(context, '${authViewM.forgetOTPverify!.data![0].reason}',
            doLogout: true);
      } else {
        setState(() {
          _otpSent = false;
        });
      }
    }
  }
}
