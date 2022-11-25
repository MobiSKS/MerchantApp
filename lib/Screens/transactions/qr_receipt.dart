import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/qr_status_model.dart';
import 'package:dtplusmerchant/model/sale_by_terminal_response.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class QRReceipt extends StatefulWidget {
  final QRStatusModel? qrStatusResp;
  const QRReceipt({super.key, this.qrStatusResp});

  @override
  State<QRReceipt> createState() => _QRReceiptState();
}

class _QRReceiptState extends State<QRReceipt> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _key = GlobalKey();
  String _copyType = "Merchant Copy";

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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: customButton(context, 'Download Merchant Copy', onTap: () {
            //     _downLoadMerchantCopy();
            //   }),
            // )
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    var custDetail = _sharedPref.user!.data!.objGetMerchantDetail![0];
    var rocName = _sharedPref.user!.data!.objOutletDetails![0];
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(
          title: AppStrings.dateTime,
          value: Utils.checkNullValue(
              widget.qrStatusResp!.data!.first.invoiceDateTime)),
      ReceiptDetail(
          title: AppStrings.terminalID,
          value: widget.qrStatusResp!.data!.first.terminalId),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(
          title: AppStrings.rocNum,
          value: Utils.checkNullValue(
              widget.qrStatusResp!.data!.first.rOCNo.toString())),
      ReceiptDetail(title: AppStrings.mobileNo, value: custDetail.mobileNo),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(
          title: AppStrings.product,
          value:
              Utils.checkNullValue(widget.qrStatusResp!.data!.first.product)),
      ReceiptDetail(
          title: AppStrings.amount,
          value: Utils.checkNullValue(widget.qrStatusResp!.data!.first.amount)),
      ReceiptDetail(
          title: AppStrings.rsp,
          value: Utils.checkNullValue(widget.qrStatusResp!.data!.first.rSP)),
      ReceiptDetail(
          title: AppStrings.volume,
          value: Utils.checkNullValue(widget.qrStatusResp!.data!.first.volume)),
      ReceiptDetail(
          title: AppStrings.balance,
          value:
              Utils.checkNullValue(widget.qrStatusResp!.data!.first.balance)),
      ReceiptDetail(
          title: AppStrings.txnID,
          value: Utils.checkNullValue(widget.qrStatusResp!.data!.first.txnId)),
    ];
    return Screenshot(
      controller: screenshotController,
      child: RepaintBoundary(
        key: _key,
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  receiptHeader(context,
                      copyType: _copyType,
                      custDetail: custDetail,
                      roc: rocName.retailOutletCity!,
                      outletName: rocName.retailOutletName!),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.02),
                  boldText('CCMS Sale', color: Colors.black, fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.02),
                  receiptDetail(context, receptDetail2),
                  receiptFooter(context, custDetail: custDetail),
                ],
              )),
        ),
      ),
    );
  }
}
