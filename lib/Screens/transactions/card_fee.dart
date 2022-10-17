import 'package:dtplusmerchant/Screens/transactions/card_fee_receipt.dart';
import 'package:dtplusmerchant/provider/transactions_provider.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/app_strings.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';
import '../../util/uiutil.dart';

class CardFee extends StatefulWidget {
  const CardFee({super.key});
  @override
  State<CardFee> createState() => _CardFeeState();
}

class _CardFeeState extends State<CardFee> {
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _formNoController = TextEditingController();
  final TextEditingController _cardnumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: normalAppBar(context, title: AppStrings.cardFee),
      body: Column(
        children: [
          title(context, AppStrings.cardFee),
          _body(context),
        ],
      ),
    ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _searchFilter(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.06,
            color: Colors.blue.shade100,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: boldText(
                AppStrings.results,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        Visibility(
          visible: (_formNoController.text.isNotEmpty &&
              _cardnumberController.text.isNotEmpty),
          child: Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _cardFeeWidget(),
          )),
        ),
      ],
    );
  }

  Widget _searchFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context) * 0.04),
          simpleTextField(context, _formNoController, AppStrings.enterFormNo),
          SizedBox(height: screenHeight(context) * 0.01),
          simpleTextField(
              context, _cardnumberController, AppStrings.enterCardNo),
          SizedBox(height: screenHeight(context) * 0.04),
          customButton(context, AppStrings.submit, onTap: () {
            submit();
          })
        ],
      ),
    );
  }

  Future<void> submit() async {
    var cardFeeProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    await cardFeeProvider.cardFeePaynment(context,
        formNumber: _formNoController.text,
        numberOfCards: int.parse(_cardnumberController.text),
        invoiceAmount: _totalAmount());
    if (cardFeeProvider.cardFeeResponseModel != null &&
        cardFeeProvider.cardFeeResponseModel!.internelStatusCode == 1000) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CardFeeReceipt(
                  amount: _totalAmount(),
                  formNum: _formNoController.text,
                  cardNumber: _cardnumberController.text,
                  txnId: cardFeeProvider.cardFeeResponseModel!.data![0].refNo,
                )),
      );
    }
  }

  Widget _cardFeeWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          width: screenWidth(context),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldText(
                    AppStrings.cardFeeTransaction,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ],
              ),
              Divider(color: Colors.indigo.shade400),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText(AppStrings.formNo,
                              color: Colors.black,
                              textAlign: TextAlign.start,
                              fontFamily: FontFamilyHelper.sourceSansRegular),
                          boldText(_formNoController.text,
                              color: Colors.black, fontSize: 16),
                        ],
                      ),
                      SizedBox(width: screenWidth(context) * 0.10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(AppStrings.numberOfCards,
                              color: Colors.black, textAlign: TextAlign.start),
                          boldText(_cardnumberController.text,
                              color: Colors.black, fontSize: 16),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          semiBoldText('Total Amount',
                              color: Colors.black, textAlign: TextAlign.start),
                          boldText(
                            '₹${_totalAmount().toString()}',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                  SizedBox(height: screenHeight(context) * 0.01),
                ],
              ),
            ],
          ),
        ),
        _footerWidget()
      ],
    );
  }

  double _totalAmount() {
    var amount =
        _sharedPref.user!.data!.objGetMerchantDetail![0].cardFeeAmount!;
    return _cardnumberController.text.isNotEmpty
        ? double.parse(amount) * (double.parse(_cardnumberController.text))
        : 0.0;
  }

  Widget _footerWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.indigo.shade300,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
    );
  }
}
