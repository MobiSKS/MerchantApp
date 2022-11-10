import 'package:dtplusmerchant/Screens/transactions/scan_qr.dart';
import 'package:dtplusmerchant/Screens/transactions/type_of_sale_screen.dart';
import 'package:dtplusmerchant/provider/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/font_family_helper.dart';
import '../../util/uiutil.dart';

class PaymentAcceptance extends StatefulWidget {
  const PaymentAcceptance({super.key});

  @override
  State<PaymentAcceptance> createState() => _PaymentAcceptanceState();
}

class _PaymentAcceptanceState extends State<PaymentAcceptance> {
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  String _payType = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedProduct = "";
  String? _productName;
  final _amountController = TextEditingController();
  List<String> payMode = [AppStrings.generateQR, AppStrings.saleWithOtp];
  late String selectedMode;

  @override
  void initState() {
    super.initState();
    selectedMode = AppStrings.generateQR;
  }

  bool _validate() {
    final FormState? form = _formKey.currentState;
    if (form!.validate() && _selectedProduct.isNotEmpty) {
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
          appBar: normalAppBar(context, title: AppStrings.paymentAcceptance),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight(context) * 0.05),
                        boldText(AppStrings.selectProduct,
                            color: Colors.grey.shade600),
                        _selectProduct(context),
                        SizedBox(height: screenHeight(context) * 0.05),
                        boldText(AppStrings.selectPaymentType,
                            color: Colors.grey.shade600),
                        _selectPaymentType(context),
                         SizedBox(height: screenHeight(context) * 0.03),
                        // boldText(AppStrings.enterAmount,
                        //     color: Colors.grey.shade600),
                        _enterAmount(context),
                        SizedBox(height: screenHeight(context) * 0.10),
                        customButton(context, AppStrings.next, onTap: () {
                          showBottomModalSheet();
                        }),
                      ],
                    ))
              ],
            ),
          )),
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
            });
          },
        ),
      ),
    );
  }

  void showBottomModalSheet() {
    _validate()
        ? showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: ((BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: screenHeight(context) * 0.39,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, bottom: 20),
                        child: boldText(AppStrings.selectType,
                            color: Colors.black, fontSize: 20),
                      ),
                      Divider(
                        color: Colors.grey.shade900,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          children: payMode.map((payThrough) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: Transform.scale(
                                      scale: 1.4,
                                      child: Radio<String>(
                                        value: payThrough,
                                        activeColor: Colors.red,
                                        groupValue: selectedMode,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedMode = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  boldText(payThrough,
                                      fontSize: 20.0, color: Colors.black)
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth(context) * 0.10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: screenWidth(context) * 0.75,
                                child: customButton(context, AppStrings.procced,
                                    onTap: () {
                                  selectedMode == AppStrings.saleWithOtp
                                      ? sale()
                                      : generateQR();
                                }))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }));
            })
        : alertPopUp(context, 'Please enter all the detail.');
  }

  void sale() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TypeOfSale(
                amount: _amountController.text,
                productId: int.parse(_selectedProduct),
                product: _productName,
              )),
    );
  }

  void generateQR() async {
    var saleViewM = Provider.of<TransactionsProvider>(context, listen: false);
    if (_validate() && _amountController.text.isNotEmpty) {
      await saleViewM.generateQR(context,
          amount: double.parse(_amountController.text),
          transTypeId: int.parse(_payType),
          productId: _selectedProduct);
      if (saleViewM.generateQrResponse!.internelStatusCode == 1000) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ScanQRCode(
                    qrString: saleViewM.generateQrResponse!.data![0].qRString,
                    amount: saleViewM.generateQrResponse!.data![0].amount,
                    outletName:
                        saleViewM.generateQrResponse!.data![0].outletName)));
      }
    }
  }

  Widget _selectProduct(BuildContext context) {
    var productList = _sharedPref.user!.data!.objProduct;
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
          hint: const Text(AppStrings.selectProduct),
          value: _selectedProduct.isEmpty ? null : _selectedProduct,
          items: productList!.map((value) {
            return DropdownMenuItem(
              value: value.productId.toString(),
              child: Text(value.productName!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedProduct = value!.toString();
              _productName = productList
                  .where((e) => e.productId == int.parse(_selectedProduct))
                  .toList()[0]
                  .productName;
            });
        },
        ),
      ),
    );
  }
FocusNode myFocusNode = FocusNode();
 void _requestFocus(FocusNode focus) {
    setState(() {
      FocusScope.of(context).requestFocus(focus);
    });
  }

  Widget _enterAmount(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: Form(
        key: _formKey,
        
        child: TextFormField(
          focusNode: myFocusNode,
          controller: _amountController,
          onTap: (){
          _requestFocus(myFocusNode);
          },
         style: const TextStyle(
            fontFamily: FontFamilyHelper.sourceSansRegular, fontSize: 18),
        validator: (val) => val!.isEmpty ? 'Please enter amount' : null,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Enter Amount',
            labelStyle: TextStyle(
                fontFamily: FontFamilyHelper.sourceSansSemiBold,
                fontSize:
                    myFocusNode.hasFocus || _amountController.text.isNotEmpty
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
