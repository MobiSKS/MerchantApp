// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../const/image_resources.dart';
import '../../model/receipt_detal.dart';

class ReceivablePayableDetailsScreen extends StatefulWidget {
  final dataItem;
  const ReceivablePayableDetailsScreen({
    super.key,
    @required this.dataItem,
  });

  @override
  State<ReceivablePayableDetailsScreen> createState() =>
      _ReceivablePayableDetailsScreenState();
}

class _ReceivablePayableDetailsScreenState
    extends State<ReceivablePayableDetailsScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: normalAppBar(context, title: AppStrings.receivablePayableDetail),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _body(context),
            SizedBox(height: screenHeight(context) * 0.02),
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    List<ReceiptDetail> transDetail = [
      ReceiptDetail(title: 'SR No.', value: '${widget.dataItem.srNumber}'),
      ReceiptDetail(
          title: 'TerminalId', value: '${widget.dataItem.terminalId}'),
      ReceiptDetail(title: 'BatchId', value: '${widget.dataItem.batchId}'),
      ReceiptDetail(
          title: 'Settlement Date',
          value:
              '${widget.dataItem.settlementDate.toString().characters.take(10)}'),
      ReceiptDetail(
          title: 'Receivable', value: '${widget.dataItem.receivable}'),
      ReceiptDetail(title: 'Payable', value: '${widget.dataItem.payable}'),
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
                  boldText('Receivable & Payable',
                      color: Colors.black, fontSize: 24.0),
                  SizedBox(height: screenHeight(context) * 0.04),
                  receiptDetail(context, transDetail, itemSapce: 17.0),
                ],
              )),
        ),
      ),
    );
  }
}
