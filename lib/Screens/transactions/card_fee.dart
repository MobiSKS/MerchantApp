import 'package:dtplusmerchant/Screens/transactions/card_fee_receipt.dart';
import 'package:dtplusmerchant/provider/sale_reload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/custom_list.dart';
import '../../const/app_strings.dart';
import '../../const/image_resources.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.black, size: 24)),
        title: headerText(AppStrings.cardFee,
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(ImageResources.notificationIcon))
        ],
      ),
      body: _body(context),
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
            color: Colors.indigo.shade200,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: headerText(AppStrings.results,
                  color: Colors.black, fontWeight: FontWeight.w500),
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
        Provider.of<SaleReloadViewModel>(context, listen: false);
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
                  txnId:   cardFeeProvider.cardFeeResponseModel!.data![0].refNo,

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
                  headerText(AppStrings.cardFeeTransaction,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
                          smallText(AppStrings.formNo,
                              color: Colors.black,
                              align: TextAlign.start,
                              fontWeight: FontWeight.normal),
                          headerText(_formNoController.text,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ],
                      ),
                      SizedBox(width: screenWidth(context) * 0.10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallText(AppStrings.numberOfCards,
                              color: Colors.black,
                              align: TextAlign.start,
                              fontWeight: FontWeight.normal),
                          headerText(_cardnumberController.text,
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                          smallText('Total Amount',
                              color: Colors.black,
                              align: TextAlign.start,
                              fontWeight: FontWeight.normal),
                          headerText('₹${_totalAmount().toString()}',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
