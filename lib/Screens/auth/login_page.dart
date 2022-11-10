// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../base/base_view.dart';
import '../../common/custom_lert_box.dart';
import '../../provider/location_provider.dart';
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
    _determinePosition();
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) => _determinePosition());
  }

  Future<Position> _determinePosition() async {
  //  LocationProvider deviceInfoProvider = Provider.of(context, listen: false);
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.phone.request();

    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();

    var phonePermissionIsDenied = await Permission.phone.isDenied;
    var phonePermissionIsPermanentlyDenied =
        await Permission.phone.isPermanentlyDenied;
    if (locationPermission == LocationPermission.denied) {
      // _determinePosition();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            dialogText:
                "Location Permission Required.\n Go to Sitting to grant access",
            FirstButtonText: "CANCEL",
            FirstButtonFunction: () => {exit(0)},
            SecondButtonText: 'OPEN SETTINGS',
            secondButtonFunction: () => {
              openAppSettings().then((value) {
                Navigator.pop(context);
              })
            },
          );
        },
      );
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            dialogText:
                "Location Permission Required.\n Go to Sitting to grant access",
            FirstButtonText: "CANCEL",
            FirstButtonFunction: () => {exit(0)},
            SecondButtonText: 'OPEN SETTINGS',
            secondButtonFunction: () => {
              openAppSettings().then((value) {
                Navigator.pop(context);
              })
            },
          );
        },
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // if (phonePermissionIsDenied) {
    //   showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertBox(
    //         dialogText:
    //             "Phone Permission Required.\n Go to Sitting to grant access",
    //         FirstButtonText: "CANCEL",
    //         FirstButtonFunction: () => {exit(0)},
    //         SecondButtonText: 'OPEN SETTINGS',
    //         secondButtonFunction: () => {
    //           openAppSettings().then((value) {
    //             Navigator.pop(context);
    //           })
    //         },
    //       );
    //     },
    //   );
    // }
    // if (phonePermissionIsPermanentlyDenied) {
    //   showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertBox(
    //         dialogText:
    //             "Phone Permission Required.\n Go to Sitting to grant access",
    //         FirstButtonText: "CANCEL",
    //         FirstButtonFunction: () => {exit(0)},
    //         SecondButtonText: 'OPEN SETTINGS',
    //         secondButtonFunction: () => {
    //           openAppSettings().then((value) {
    //             Navigator.pop(context);
    //           })
    //         },
    //       );
    //     },
    //   );
    // }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  // await deviceInfoProvider.getLocation(position.latitude, position.longitude);
    return await Geolocator.getCurrentPosition();
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
                        child: underlinedText(AppStrings.forgotPassword,
                            fontSize: 16))
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
          semiBoldText(AppStrings.welcomeBack,
              fontSize: 22.0, color: Colors.white),
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
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        validator: (val) => val!.isEmpty ? AppStrings.userNameEmptyMsg : null,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person, size: 20),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            filled: true,
            hintStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: FontFamilyHelper.sourceSansRegular),
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
            hintStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: FontFamilyHelper.sourceSansRegular),
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
        semiBoldText(AppStrings.rememberMe, color: Colors.black)
      ],
    );
  }

  Widget _footerWidget() {
    var textStyle = const TextStyle(
        decoration: TextDecoration.underline,
        color: Colors.white,
        fontFamily: FontFamilyHelper.sourceSansRegular,
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
              fontSize: 22,
              fontFamily: FontFamilyHelper.sourceSansBold,
              color: Colors.white),
        ),
      ),
    );
  }
}
