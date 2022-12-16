import 'package:dtplusmerchant/model/transaction_detail_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../const/common_param.dart';
import '../../const/image_resources.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class TransactionSummarydetail extends StatefulWidget {
  final Data data;
  const TransactionSummarydetail({
    super.key,
    required this.data,
  });

  @override
  State<TransactionSummarydetail> createState() =>
      _TransactionSummarydetailState();
}

class _TransactionSummarydetailState extends State<TransactionSummarydetail> {
  final ScreenshotController screenshotController = ScreenshotController();
  final _sharedPref = Injection.injector.get<SharedPref>();
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
            receiptTitle(context, _key),
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    var merchant = _sharedPref.user!.data!.objGetMerchantDetail!.first;

    List<ReceiptDetail> transDetail = [
      ReceiptDetail(title: 'Date', value:Utils.checkNullValue(widget.data.transactionDate) ),
      ReceiptDetail(title: 'Batch No.', value:  Utils.checkNullValue( widget.data.batchId.toString())),
      ReceiptDetail(title: 'ROC No.', value: ''),
      ReceiptDetail(title: 'Mobile No.', value: Utils.checkNullValue(widget.data.mobileNo)),
      ReceiptDetail(title: 'Card No.', value: widget.data.cardNo),
      ReceiptDetail(
          title: 'Transaction Type', value: Utils.checkNullValue(widget.data.transactionType)),
      ReceiptDetail(title: 'Product', value: '${widget.data.product}'),
      ReceiptDetail(title: 'Amount', value: '$rupeeSign ${widget.data.amount}'),
      ReceiptDetail(title: 'RSP', value: ''),
      ReceiptDetail(title: 'Volume', value: '${widget.data.volume}'),
      ReceiptDetail(title: 'Balance', value: ''),
      ReceiptDetail(title: 'Txn ID', value: ''),
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
                  boldText(merchant.header2!,
                      color: Colors.black, fontSize: 22.0),
                  boldText(merchant.merchantName!,
                      color: Colors.black, fontSize: 22.0),
                  SizedBox(height: screenHeight(context) * 0.07),
                  receiptDetail(context, transDetail, itemSapce: 17.0),
                  SizedBox(height: screenHeight(context) * 0.02),
                  receiptFooter(context, custDetail: merchant),
                ],
              )),
        ),
      ),
    );
  }
}
