import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/transaction_detail_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../const/image_resources.dart';
import '../../model/receipt_detal.dart';

class TransactionSummarydetail extends StatefulWidget {
  final  Data data;
  const TransactionSummarydetail( {super.key, required this.data, });

  @override
  State<TransactionSummarydetail> createState() =>
      _TransactionSummarydetailState();
}

class _TransactionSummarydetailState extends State<TransactionSummarydetail> {
  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
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
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    
    List<ReceiptDetail> transDetail = [
      ReceiptDetail(title: AppStrings.rocNum, value: ''),
      ReceiptDetail(title: 'Account Number', value: ''),
      ReceiptDetail(
          title: 'Transaction Date/Time', value: widget.data.transactionDate),
      ReceiptDetail(title: 'Transaction Type', value: widget.data.transactionType),
      ReceiptDetail(title: 'Amount', value: '₹ ${widget.data.amount}'),
      ReceiptDetail(title: 'CCMS/Cash Bal', value: ''),
      ReceiptDetail(title: 'Voided ROC', value: widget.data.voidedRoc),
      ReceiptDetail(title: 'Voided By ROC', value: widget.data.voidedByRoc),
      ReceiptDetail(title: 'Product', value: widget.data.product),
      ReceiptDetail(title: 'Price', value: '₹ ${widget.data.price}'),
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
                  SizedBox(height: screenHeight(context) * 0.02),
                  Image.asset(ImageResources.hpLogoReceipt, height: 100),
                  SizedBox(height: screenHeight(context) * 0.015),
                  boldText('Transaction  Detail',
                      color: Colors.black, fontSize: 24.0),
                        SizedBox(height: screenHeight(context) * 0.07),
                  receiptDetail(context, transDetail,itemSapce: 17.0),
                ],
              )),
        ),
      ),
    );
  }
}
