import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/paycode_response_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class PayCodeReceipt extends StatefulWidget {
  final PaycodeResponseModel payCodeResp;
  const PayCodeReceipt({super.key, required this.payCodeResp});

  @override
  State<PayCodeReceipt> createState() => _PayCodeReceiptState();
}

class _PayCodeReceiptState extends State<PayCodeReceipt> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
  String _copyType = 'CUSTOMER COPY';
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
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30),
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
    var outLetDetail = _sharedPref.user!.data!.objOutletDetails![0];
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(title: AppStrings.dateTime, value: Utils.dateTimeFormat()),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(title: AppStrings.rocNum, value: widget.payCodeResp.data!.first.rocNo),
      ReceiptDetail(title: 'CARD NO.', value:widget.payCodeResp.data!.first.cardNoOutput),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(
          title: AppStrings.product,
          value: widget.payCodeResp.data![0].productName),
      ReceiptDetail(
          title: AppStrings.amount, value: widget.payCodeResp.data![0].invAmt),
      ReceiptDetail(
          title: AppStrings.rsp, value: widget.payCodeResp.data![0].rSP),
      ReceiptDetail(
          title: AppStrings.volume, value: widget.payCodeResp.data![0].volume),
      ReceiptDetail(
          title: AppStrings.balance,
          value: widget.payCodeResp.data![0].balance),
      ReceiptDetail(
          title: AppStrings.txnID, value: widget.payCodeResp.data![0].refNo),
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
                  receiptHeader(context,
                      copyType: _copyType,
                      custDetail: custDetail,
                      outletName: outLetDetail.retailOutletName!),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.02),
                  boldText('PAYCODE',
                      color: Colors.black,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.02),
                  receiptDetail(context, receptDetail2),
                  receiptFooter(context, custDetail: custDetail),
                ],
              )),
        ),
      )
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
