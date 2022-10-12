import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/transaction_detail_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class TransactionSummarydetail extends StatefulWidget {
  final TransactionDetailModel transdetail;
  const TransactionSummarydetail({super.key, required this.transdetail});

  @override
  State<TransactionSummarydetail> createState() => _TransactionSummarydetailState();
}

class _TransactionSummarydetailState extends State<TransactionSummarydetail> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
  String _copyType = 'Transaction Summary Detail';
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
            //receiptTitle(context, _key),
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
            // customButton(context, 'Download Merchant Copy', onTap: () {
            //   _downLoadMerchantCopy();
            // })
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    var custDetail = _sharedPref.user!.data!.objGetMerchantDetail![0];
  
    List<ReceiptDetail> transDetail = [
      ReceiptDetail(
          title: AppStrings.rocNum,
          value: ''),
      ReceiptDetail(
          title: 'Account Number', value: ''),
      ReceiptDetail(
          title: 'Transaction Date/Time', value: ''),
      ReceiptDetail(
          title: AppStrings.amount, value: ''),
      ReceiptDetail(
          title: 'CCMS/Cash Bal',
          value: ''),
      ReceiptDetail(
          title: AppStrings.txnID, value: ''),
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
             
                 
                
                  SizedBox(height: screenHeight(context) * 0.02),
                  receiptDetail(context, transDetail),
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
