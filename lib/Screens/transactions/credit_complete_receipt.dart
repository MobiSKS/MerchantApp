import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/sale_by_terminal_response.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

class CreditCompleteReceipt extends StatefulWidget {
  final SaleByTeminalResponse creditCompResp;
  const CreditCompleteReceipt({super.key, required this.creditCompResp});

  @override
  State<CreditCompleteReceipt> createState() => _CreditCompleteReceiptState();
}

class _CreditCompleteReceiptState extends State<CreditCompleteReceipt> {
  final _sharedPref = Injection.injector.get<SharedPref>();

  final ScreenshotController screenshotController = ScreenshotController();
  final _copyType = ValueNotifier<String>("CUSTOMER COPY");
  final GlobalKey _key = GlobalKey();

  @override
  void dispose() {
    super.dispose();

    _copyType.dispose();
  }

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
            customButton(context, 'Download Merchant Copy', onTap: () {
              _downLoadMerchantCopy();
            })
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
      ReceiptDetail(
          title: 'CTRL CARD NO.',
          value: widget.creditCompResp.data![0].cardNoOutput),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(
          title: AppStrings.amount,
          value: widget.creditCompResp.data![0].invAmt),
      ReceiptDetail(
          title: AppStrings.balance,
          value: widget.creditCompResp.data![0].balance),
      ReceiptDetail(
          title: AppStrings.txnID, value: widget.creditCompResp.data![0].refNo),
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
                      copyType: _copyType.value,
                      custDetail: custDetail,
                      outletName:
                          widget.creditCompResp.data![0].retailOutletName),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.020),
                  boldText('SALE(FASTAG)', color: Colors.black, fontSize: 20.0),
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
    _copyType.value = 'MERCHANT COPY';
    showLoader(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      captureAndSharePng(context, _key, pop: false);
    });
    dismissLoader(context);
  }
}
