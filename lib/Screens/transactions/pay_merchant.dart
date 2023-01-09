// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/Screens/transactions/paycode_receipt.dart';
import 'package:dtplusmerchant/preferences/shared_preference.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../const/image_resources.dart';
import '../../const/injection.dart';
import '../../provider/transactions_provider.dart';
import '../../util/font_family_helper.dart';
import '../../util/uiutil.dart';
import 'gift_voucher_screen.dart';

class PayMerchant extends StatefulWidget {
  const PayMerchant({super.key});

  @override
  State<PayMerchant> createState() => _PayMerchantState();
}

class _PayMerchantState extends State<PayMerchant> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  final _payCodeController = TextEditingController();
  late String selectedMode;
  FocusNode myFocusNode = FocusNode();
  bool _both = false;
  bool _gv = false;
  bool _pc = false;
  @override
  void initState() {
    super.initState();
  }

  bool _validate() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  int getLength() {
    int? length;
    var transType = _sharedPref.user!.data!.objGetTransTypeDetail!;
    for (var transId in transType) {
      if (transId.transType == 532) {
        if (transId.transType == 575) {
          length = 2;
        } else {
          length = 1;
        }
      } else {
        length = 1;
      }
    }
    return length!;
  }

  List<Widget> getChildren() {
    List<Widget> widget = [];
    var transType = _sharedPref.user!.data!.objGetTransTypeDetail!;
    var filteredList = transType
        .where((e) => e.transType == 532 || e.transType == 575)
        .toList();

    for (var transId in filteredList) {
      if (transId.transType == 532) {
        if (transId.transType == 575) {
          widget = <Widget>[
            _payCodeWidget(),
            const GiftVoucherScreen(),
          ];
        } else {
          widget = <Widget>[
            _payCodeWidget(),
          ];
        }
      } else {
        widget = <Widget>[
          const GiftVoucherScreen(),
        ];
      }
    }
    return widget.toSet().toList();
  }

  List<Widget> getTabs() {
    List<Widget> widget = [];
    var transType = _sharedPref.user!.data!.objGetTransTypeDetail!;
    var filteredList = transType
        .where((e) => e.transType == 532 || e.transType == 575)
        .toList();
    for (var transId in filteredList) {
      if (transId.transType == 532) {
        if (transId.transType == 575) {
          widget = <Widget>[
            const Tab(text: "Pay Code"),
            const Tab(text: "Gift Voucher")
          ];
        } else {
          widget = <Widget>[
            const Tab(text: "Pay Code"),
          ];
        }
      } else {
        widget = <Widget>[const Tab(text: "Gift Voucher")];
      }
    }
    return widget.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: getLength(),
          child: Scaffold(
              appBar: payCodeAppBar(),
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: TabBarView(children: getChildren()))),
    );
  }

  Widget _payCodeWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight(context) * 0.05),
                  _enterpayCode(context),
                  SizedBox(height: screenHeight(context) * 0.10),
                  customButton(context, AppStrings.submit, onTap: () {
                    submitOTPSale();
                  }),
                ],
              ))
        ],
      ),
    );
  }

  payCodeAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(screenHeight(context) * 0.157),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 27,
                      )),
                ],
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  Image.asset(ImageResources.driveTruckPlusImage,
                      height: screenHeight(context) * 0.032),
                ],
              ),
              centerTitle: true,
              actions: [
                Column(
                  children: [
                    const SizedBox(
                      height: 23,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.notifications,
                            color: Colors.grey, size: 26)),
                  ],
                ),
                const SizedBox(width: 20)
              ],
            ),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.06,
            color: Colors.blue.shade100,
            child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                labelStyle: const TextStyle(
                    fontSize: 22,
                    fontFamily: FontFamilyHelper.sourceSansSemiBold),
                tabs: getTabs()),
          )
        ],
      ),
    );
  }

  Future<void> submitOTPSale() async {
    if (_validate()) {
      var transactionPro =
          Provider.of<TransactionsProvider>(context, listen: false);
      await transactionPro.payByPaycode(
        context,
        payCode: _payCodeController.text,
      );
      if (transactionPro.paycodeResponseModel != null &&
          transactionPro.paycodeResponseModel!.internelStatusCode == 1000) {
        Utils.textToSpeech(
            transactionPro.paycodeResponseModel!.data![0].invAmt!);
        showToast('Payment Successfull', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PayCodeReceipt(
                    payCodeResp: transactionPro.paycodeResponseModel!,
                  )),
        );
      }
    }
  }

  void _requestFocus(FocusNode focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  Widget _enterpayCode(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: Form(
        key: _formKey,
        child: TextFormField(
          onTap: () {
            _requestFocus(myFocusNode);
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
          ],
          focusNode: myFocusNode,
          controller: _payCodeController,
          validator: (val) => (val!.isEmpty || val.length != 6)
              ? 'Please enter valid Paycode'
              : null,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: 'Enter Pay Code',
              labelStyle: TextStyle(
                  fontFamily: FontFamilyHelper.sourceSansSemiBold,
                  fontSize:
                      myFocusNode.hasFocus || _payCodeController.text.isNotEmpty
                          ? 23
                          : 18,
                  color: myFocusNode.hasFocus
                      ? Colors.grey.shade700
                      : Colors.grey.shade700)),
        ),
      ),
    );
  }
}
