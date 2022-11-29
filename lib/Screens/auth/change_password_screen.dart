// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../base/base_view.dart';
import '../../const/app_strings.dart';
import '../../util/uiutil.dart';
import 'auth_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  OtpFieldController _otpController = OtpFieldController();
  String otp = "";
  bool _otpSent = false;
  bool validateAndSave() {
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
                  _chagePasswordForm(context),
                  const SizedBox(height: 10),
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

  Widget _chagePasswordForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        semiBoldText('Change Password', fontSize: 24.0, color: Colors.white),
        SizedBox(height: screenHeight(context) * 0.05),
        customTextField(context, _oldPassword, 'Old Password',
            prefixIcon: false, valMessage: 'Please enter Old Password'),
        SizedBox(height: screenHeight(context) * 0.03),
        customTextField(context, _newPassword, AppStrings.newPassword,
            prefixIcon: false, valMessage: AppStrings.newPasswordError),
        SizedBox(height: screenHeight(context) * 0.03),
        customTextField(context, _confirmPassword, AppStrings.confirmPaasword,
            prefixIcon: false, valMessage: AppStrings.confirmPassError),
      ],
    );
  }

  Widget _otpTextField(
    BuildContext context,
    OtpFieldController controller, {
    Color color = Colors.white,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        semiBoldText('Enter OTP', color: Colors.white),
        const SizedBox(height: 13),
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

  Future<void> generateOTP(AuthViewModel authViewM) async {
    if (validateAndSave()) {
      await authViewM.changePasswordOTP(context,
          confirmNewPass: _confirmPassword.text,
          newPass: _newPassword.text,
          oldPass: _oldPassword.text);

      if (authViewM.changePasswordOTp != null &&
          authViewM.changePasswordOTp!.internelStatusCode == 1000) {
        showToast('${authViewM.changePasswordOTp!.data![0].oTP}', false);
        // alertPopUp(
        //   context,
        //   '${authViewM.changePasswordOTp!.data![0].reason}',
        //  );
        if (authViewM.changePasswordOTp!.data![0].oTP != null) {
          setState(() {
            _otpSent = true;
          });
        }
      }
    }
  }

  Future<void> verifyOTP(AuthViewModel authViewM) async {
    if (validateAndSave() && otp.length == 6) {
      await authViewM.verifyChangePasswordOtp(context,
          otp: otp,
          confirmNewPass: _confirmPassword.text,
          newPass: _newPassword.text,
          oldPass: _oldPassword.text);
      if (authViewM.changePasswordModel != null &&
          authViewM.changePasswordModel!.internelStatusCode == 1000) {
        alertPopUp(context, '${authViewM.changePasswordModel!.data![0].reason}',
            doLogout: true);
      } else {
        setState(() {
          _otpSent = false;
        });
      }
    }
  }
}
