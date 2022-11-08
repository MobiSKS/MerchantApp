import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/sale_by_terminal_response.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class SaleReceipt extends StatefulWidget {
  final SaleByTeminalResponse saleResponse;
  final String mobileNo;
  final String transType;
  final String productName;
  const SaleReceipt(
      {super.key,
      required this.saleResponse,
      required this.mobileNo,
      required this.transType,
      required this.productName});

  @override
  State<SaleReceipt> createState() => _SaleReceiptState();
}

class _SaleReceiptState extends State<SaleReceipt> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();

 final GlobalKey _key = GlobalKey();
  String _copyType = AppStrings.customerCopy;

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
      ReceiptDetail(title: AppStrings.dateTime, value: '14/09/22 12:57:08'),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(title: AppStrings.rocNum, value: '1'),
      ReceiptDetail(title: AppStrings.mobileNo, value: custDetail.mobileNo),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(
          title: AppStrings.product,
          value:
              widget.saleResponse.data![0].productName ?? widget.productName),
      ReceiptDetail(
          title: AppStrings.amount, value: widget.saleResponse.data![0].invAmt),
      ReceiptDetail(
          title: AppStrings.rsp, value: widget.saleResponse.data![0].rSP),
      ReceiptDetail(
          title: AppStrings.volume, value: widget.saleResponse.data![0].volume),
      ReceiptDetail(
          title: AppStrings.balance,
          value: widget.saleResponse.data![0].balance),
      ReceiptDetail(
          title: AppStrings.txnID, value: widget.saleResponse.data![0].refNo),
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
                      outletName:
                          widget.saleResponse.data![0].retailOutletName),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.02),
                  boldText('${widget.transType}(CARD)',
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
      _copyType = AppStrings.merchantCopy;
    });
    showLoader(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      captureAndSharePng(context, _key, pop: false);
    });
    dismissLoader(context);
  }
}
