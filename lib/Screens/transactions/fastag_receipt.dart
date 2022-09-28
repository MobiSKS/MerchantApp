import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/fastag_otp_cofirm_model.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../const/injection.dart';
import '../../model/receipt_detal.dart';
import '../../preferences/shared_preference.dart';

// ignore: must_be_immutable
class FasTagReceipt extends StatefulWidget {
  String? bankNAme;
  String? mobileNum;
  String? productName;

  FastTagOtpConfirmModel? fastTagDetail;
  FasTagReceipt(
      {super.key,
      required this.bankNAme,
      this.mobileNum,
      this.productName,
      this.fastTagDetail});

  @override
  State<FasTagReceipt> createState() => _FasTagReceiptState();
}

class _FasTagReceiptState extends State<FasTagReceipt> {
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
    var outletDetail = _sharedPref.user!.data!.objOutletDetails![0];
    var receiptEntity = _sharedPref.fastTagData!;
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(title: AppStrings.dateTime, value: '14/09/22 12:57:08'),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(title: AppStrings.rocNum, value: '1'),
      ReceiptDetail(title: 'VEH NO.', value: receiptEntity.data!.vRN),
      ReceiptDetail(title: AppStrings.mobileNo, value: widget.mobileNum),
      ReceiptDetail(title: 'BANK NAME', value: widget.bankNAme),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(title: AppStrings.product, value: widget.productName ?? ''),
      ReceiptDetail(title: AppStrings.amount, value: receiptEntity.data!.vRN),
      ReceiptDetail(
          title: AppStrings.rsp, value: widget.fastTagDetail!.data!.rSP ?? ''),
      ReceiptDetail(
          title: AppStrings.volume,
          value: widget.fastTagDetail!.data!.rSP ?? ''),
      ReceiptDetail(
          title: AppStrings.txnID,
          value: widget.fastTagDetail!.data!.txnId ?? ''),
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
                      outletName: outletDetail.retailOutletName),
                  receiptDetail(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.020),
                  boldText('SALE(FASTAG)',
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
