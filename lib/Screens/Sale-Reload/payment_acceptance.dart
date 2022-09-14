import 'package:dtplusmerchant/Screens/Sale-Reload/type_of_sale_screen.dart';
import 'package:flutter/material.dart';

import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';

class PaymentAcceptance extends StatefulWidget {
  const PaymentAcceptance({super.key});

  @override
  State<PaymentAcceptance> createState() => _PaymentAcceptanceState();
}

class _PaymentAcceptanceState extends State<PaymentAcceptance> {
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  String _selectedProduct = "";
  final _amountController = TextEditingController();
  List<String> payMode = [AppStrings.generateQR, AppStrings.sale];
  late String selectedMode;

  @override
  void initState() {
    super.initState();
    selectedMode = AppStrings.generateQR;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                header(context),
                SizedBox(height: screenHeight(context) * 0.02),
                title(context, AppStrings.paymentAcceptance),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight(context) * 0.05),
                        headerText(AppStrings.selectProduct,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500),
                        _selectProduct(context),
                        SizedBox(height: screenHeight(context) * 0.05),
                        headerText(AppStrings.enterAmount,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500),
                        _enterAmount(context),
                        SizedBox(height: screenHeight(context) * 0.10),
                        customButton(context, AppStrings.next,
                            onTap: showBottomModalSheet),
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  void showBottomModalSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: ((BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SizedBox(
              height: screenHeight(context) * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 20),
                    child: headerText(AppStrings.selectType,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey.shade900,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      children: payMode.map((payThrough) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
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
                              const SizedBox(
                                width: 10,
                              ),
                              smallText(payThrough, size: 15.0)
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
                                onTap: selectedMode == AppStrings.sale
                                    ? sale
                                    : generateQR))
                      ],
                    ),
                  )
                ],
              ),
            );
          }));
        });
  }

  void sale() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TypeOfSale(
                amount: _amountController.text,
                productId: int.parse(_selectedProduct),
              )),
    );
  }

  void generateQR() {
    Navigator.pushNamed(context, "/scanQRcode");
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
            });
          },
        ),
      ),
    );
  }

  Widget _enterAmount(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter Amount',
        ),
      ),
    );
  }
}
