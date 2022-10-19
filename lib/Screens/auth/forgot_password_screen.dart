// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
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
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _oldPassword = TextEditingController();
  final bool _otpSent = false;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: customButton(context, AppStrings.submit, onTap: () {
                changePassword(auth);
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

 Future <void> changePassword(AuthViewModel authViewM) async {
    if (validateAndSave() && (_newPassword.text == _confirmPassword.text)) {
      await authViewM.changePasswordApi(context,
          confirmNewPass: _confirmPassword.text,
          newPass: _newPassword.text,
          oldPass: _oldPassword.text);

      if (authViewM.changePasswordModel!.internelStatusCode == 1000) {
      //  await authViewM.logout(context);
        alertPopUp(context, 'Password has been Changed Successfully',doLogout: true);
      }
    }else if(validateAndSave() && (_newPassword.text != _confirmPassword.text)){
       alertPopUp(context, 'New Password and Confirm Password are different.');
    }
  }

  Widget _forgetPasswordForm(BuildContext context) {
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
}
