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
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final OtpFieldController _otpController = OtpFieldController();
  String otp = "";
  bool _otpSent = false;
  bool _validateAndSave() {
    final FormState? form = _formKey1.currentState;
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
        appBar: normalAppBar(context, title: 'Change Password'),
        body: SingleChildScrollView(
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BaseView<AuthViewModel>(builder: (context, auth, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                _chagePasswordForm(context),
                const SizedBox(height: 15),
                _otpSent ? _otpTextField(context, _otpController) : Container()
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
      );
    });
  }

  Widget _chagePasswordForm(BuildContext context) {
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight(context) * 0.05),
          simpleTextField(
            context,
            _oldPassword,
            'Old Password',
            valMsg: 'Old password cant be empty',
          ),
          SizedBox(height: screenHeight(context) * 0.03),
          simpleTextField(context, _newPassword, AppStrings.newPassword,
              valMsg: "New Password can't be empty"),
          SizedBox(height: screenHeight(context) * 0.03),
          simpleTextField(context, _confirmPassword, AppStrings.confirmPaasword,
              valMsg: "Confirm password can't be empty"),
        ],
      ),
    );
  }

  Widget _otpTextField(
    BuildContext context,
    OtpFieldController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        semiBoldText('Enter OTP', color: Colors.grey.shade700),
        const SizedBox(height: 5),
        OTPTextField(
          controller: controller,
          length: 6,
          width: screenWidth(context),
          fieldWidth: 50,
          style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
          textFieldAlignment: MainAxisAlignment.spaceBetween,
          fieldStyle: FieldStyle.underline,
          keyboardType: TextInputType.number,
          otpFieldStyle: OtpFieldStyle(
              enabledBorderColor: Colors.grey.shade700,
              disabledBorderColor: Colors.grey.shade700 //(here)
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
    if (_validateAndSave()) {
      if (_newPassword.text == _confirmPassword.text) {
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
      }else {
      alertPopUp(context, 'New password and confirm password is different');
    }
    } 
  }

  Future<void> verifyOTP(AuthViewModel authViewM) async {
    if (_validateAndSave() && otp.length == 6) {
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
