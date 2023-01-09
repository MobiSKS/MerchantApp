
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/model/sale_by_terminal_response.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:dtplusmerchant/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard', (Route<dynamic> route) => false);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              header(context),
              SizedBox(height: screenHeight(context) * 0.02),
              receiptTitle(context, _key),
              _body(context),
              SizedBox(height: screenHeight(context) * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child:
                    customButton(context, 'Download Merchant Copy', onTap: () {
                  _downLoadMerchantCopy();
                }),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _body(BuildContext context) {
    var custDetail = _sharedPref.user!.data!.objGetMerchantDetail![0];
    var rocName = _sharedPref.user!.data!.objOutletDetails![0].retailOutletCity;
    var date = Utils.dateTimeFormat().split(' ')[0];
    var time = Utils.dateTimeFormat().split(' ')[1];
    var dateF =
        Utils.convertDateFormatInDDMMYY(DateFormat("yyyy-MM-dd").parse(date));
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(title: AppStrings.dateTime, value: "$dateF $time"),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(
          title: AppStrings.rocNum,
          value: widget.saleResponse.data!.first.rOCNo),
      ReceiptDetail(title: AppStrings.mobileNo, value: widget.mobileNo),
      ReceiptDetail(title:'Card No' ,value:Utils.checkNullValue(widget.saleResponse.data![0].cardNoOutput!) )
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
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15, top: 10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    receiptHeader(
                      context,
                      copyType: _copyType,
                      custDetail: custDetail,
                      roc: rocName!,
                      outletName: _sharedPref
                          .user!.data!.objOutletDetails!.first.retailOutletName,
                    ),
                    receiptDetail(context, receptDetail1),
                    SizedBox(height: screenHeight(context) * 0.01),
                    semiBoldText(widget.transType,
                        color: Colors.black, fontSize: 18.0),
                    SizedBox(height: screenHeight(context) * 0.01),
                    receiptDetail(context, receptDetail2),
                    receiptFooter(context, custDetail: custDetail),
                  ],
                )),
          ),
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
