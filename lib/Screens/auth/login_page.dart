// ignore_for_file: use_build_context_synchronously
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import '../../base/base_view.dart';
import 'auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;
  late bool _rememberVal;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _scrollController = ScrollController();

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _rememberVal = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            backgroundImage(context),
            _body(context),
            Positioned(
                bottom: 0.0,
                child: Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.06,
                  color: Colors.red,
                  child: _footerWidget(),
                ))
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (context, authViewM, child) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight(context) * 0.07),
              hpLogo(context),
              SizedBox(height: screenHeight(context) * 0.04),
              driverTruckTextImage(context),
              SizedBox(height: screenHeight(context) * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: _loginForm(),
              ),
              SizedBox(height: screenHeight(context) * 0.025),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _rememberMe()),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgotPassword");
                        },
                        child: underlinedText(AppStrings.forgotPassword))
                  ],
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 40),
                child: Column(
                  children: [
                    _submitButton(authViewM),
                    SizedBox(height: screenHeight(context) * 0.07),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(AppStrings.welcomeBack),
          SizedBox(height: screenHeight(context) * 0.030),
          _userNameField(),
          SizedBox(height: screenHeight(context) * 0.030),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _userNameField() {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        controller: userNameController,
        keyboardType: TextInputType.number,
        validator: (val) => val!.isEmpty ? AppStrings.userNameEmptyMsg : null,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person, size: 20),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            filled: true,
        
            hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
            hintText: AppStrings.userName,
            fillColor: Colors.white),
      ),
    );
  }

  Widget _passwordField() {
    return SizedBox(
      width: screenWidth(context),
      child: TextFormField(
        validator: (val) => val!.isEmpty ? AppStrings.passwordEmptyMsg : null,
        obscureText: !_passwordVisible,
        controller: passwordController,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password, size: 20),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: _passwordVisible
                    ? const Icon(Icons.visibility, size: 20)
                    : const Icon(Icons.visibility_off, size: 20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
            hintText: AppStrings.password,
            fillColor: Colors.white),
      ),
    );
  }

  Widget _rememberMe() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
              value: _rememberVal,
              onChanged: (val) {
                setState(() {
                  _rememberVal = !_rememberVal;
                });
              }),
        ),
        smallText(AppStrings.rememberMe)
      ],
    );
  }

  Widget _footerWidget() {
    var textStyle = const TextStyle(
        decoration: TextDecoration.underline,
        color: Colors.white,
        fontSize: 16);
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 15.0, top: 8, bottom: 8),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.retailOutletOnMap, style: textStyle),
            const VerticalDivider(
              color: Colors.white,
              width: 20,
            ),
            Text(AppStrings.locateDTplusOutlet, style: textStyle)
          ],
        ),
      ),
    );
  }

  Widget _submitButton(AuthViewModel authViewM) {
    return SizedBox(
      width: screenWidth(context),
      height: screenHeight(context) * 0.06,
      child: TextButton(
        onPressed: () async {
          if (validateAndSave()) {
            await authViewM.loginApi(
                context, userNameController.text, passwordController.text);
            if (authViewM.userModel!.internelStatusCode! == 1000) {
              showToast('LoggedIn', false);
              Navigator.pushNamedAndRemoveUntil(
                  context, "/dashboard", (route) => false);
            } else {
              alertPopUp(context, authViewM.userModel!.message!);
            }
          }
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade900),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.blue.shade900)))),
        child: const Text(
          AppStrings.submit,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
