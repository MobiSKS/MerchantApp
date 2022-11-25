import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class CardFeeReceipt extends StatefulWidget {
  final String? formNum;
  final double? amount;
  final String? cardNumber;
  final String? txnId;
  const CardFeeReceipt(
      {super.key, this.formNum, this.amount, this.cardNumber, this.txnId});

  @override
  State<CardFeeReceipt> createState() => _CardFeeReceiptState();
}

class _CardFeeReceiptState extends State<CardFeeReceipt> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
  String _copyType = "CUSTOMER COPY";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context),
            SizedBox(height: screenHeight(context) * 0.02),
            receiptTitle(context, _key),
            SizedBox(height: screenHeight(context) * 0.02),
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: customButton(context, 'Download Merchant Copy', onTap: () {
                _downLoadMerchantCopy();
              }),
            )
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    var custDetail = _sharedPref.user!.data!.objGetMerchantDetail![0];
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(title: AppStrings.dateTime, value: Utils.dateTimeFormat()),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(title: AppStrings.rocNum, value: ''),
      ReceiptDetail(title: AppStrings.formNo, value: widget.formNum),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(title: 'CARD COUNT', value: widget.cardNumber),
      ReceiptDetail(title: AppStrings.amount, value: '₹ ${widget.amount}'),
      ReceiptDetail(title: AppStrings.txnID, value: widget.txnId),
    ];

    return Screenshot(
      controller: screenshotController,
      child: RepaintBoundary(
        key: _key,
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  receiptHeader(
                    context,
                    copyType: _copyType,
                    custDetail: custDetail,
                    outletName: _sharedPref
                        .user!.data!.objOutletDetails![0].retailOutletName!,
                  ),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.020),
                  boldText('SALE',
                      color: Colors.black,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.02),
                  receiptDetail(context, receptDetail2),
                  receiptFooter(context, custDetail: custDetail),
                ],
              )),
        ),
      ),
    );
  }

  void _downLoadMerchantCopy() {
    setState(() {
      _copyType = 'MERCHANT COPY';
    });
    showLoader(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      captureAndSharePng(context, _key, pop: false);
    });
    dismissLoader(context);
  }
}
