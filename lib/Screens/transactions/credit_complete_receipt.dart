import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/model/sale_by_terminal_response.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../common/download_widget.dart';
import '../../common/share_widget.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';

// ignore: must_be_immutable
class CreditCompleteReceipt extends StatelessWidget {
  final SaleByTeminalResponse creditCompResp;
  CreditCompleteReceipt({super.key, required this.creditCompResp});
  final _sharedPref = Injection.injector.get<SharedPref>();
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
            title(context, 'Receipt'),
            SizedBox(height: screenHeight(context) * 0.04),
            _body(context)
          ],
        ),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    var custDetail = _sharedPref.user!.data!.objGetMerchantDetail![0];
    var outletcity =
        _sharedPref.user!.data!.objOutletDetails![0].retailOutletCity;
    List<ReceiptDetail> receptDetail1 = [
      ReceiptDetail(title: AppStrings.dateTime, value: '14/09/22 12:57:08'),
      ReceiptDetail(title: 'OPERATOR', value: '1'),
      ReceiptDetail(
          title: AppStrings.terminalID, value: custDetail.terminalId!),
      ReceiptDetail(title: AppStrings.batchNum, value: custDetail.batchNo),
      ReceiptDetail(title: AppStrings.rocNum, value: '1'),
      ReceiptDetail(
          title: 'CTRL CARD NO.', value: creditCompResp.data![0].cardNoOutput),
    ];
    List<ReceiptDetail> receptDetail2 = [
      ReceiptDetail(
          title: AppStrings.amount, value: creditCompResp.data![0].invAmt),
      ReceiptDetail(
          title: AppStrings.balance, value: creditCompResp.data![0].balance),
      ReceiptDetail(
          title: AppStrings.txnID, value: creditCompResp.data![0].refNo),
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
                  Image.asset(ImageResources.hpLogoReceipt, height: 100),
                  SizedBox(height: screenHeight(context) * 0.02),
                  headerText(AppStrings.customerCopy,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.01),
                  headerText(custDetail.header1!,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.01),
                  headerText(custDetail.header2!,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.01),
                  headerText(creditCompResp.data![0].retailOutletName!,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.01),
                  headerText(outletcity!,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.05),
                  _merchantDetail1(context, receptDetail1),
                  SizedBox(height: screenHeight(context) * 0.04),
                  headerText('CREDIT SALE COMPLETE',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.02),
                  _merchantDetail2(context, receptDetail2),
                  SizedBox(height: screenHeight(context) * 0.05),
                  headerText(custDetail.footer1!,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0),
                  SizedBox(height: screenHeight(context) * 0.01),
                  headerText(custDetail.footer2!,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0),
                ],
              )),
        ),
      ),
    );
  }

  Widget _merchantDetail1(
    BuildContext context,
    List<ReceiptDetail> receptDetail1,
  ) {
    return CustomList(
        list: receptDetail1,
        itemSpace: 10,
        child: (ReceiptDetail data, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallText(data.title!, size: 16.0, fontWeight: FontWeight.w500),
              smallText(data.value!, size: 16.0, fontWeight: FontWeight.w500),
            ],
          );
        });
  }

  Widget _merchantDetail2(
    BuildContext context,
    List<ReceiptDetail> receptDetail2,
  ) {
    return CustomList(
        list: receptDetail2,
        itemSpace: 10,
        child: (ReceiptDetail data, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallText(data.title!, size: 16.0, fontWeight: FontWeight.w500),
              smallText(data.value!, size: 16.0, fontWeight: FontWeight.w500),
            ],
          );
        });
  }

  Widget title(context, String text) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.06,
      color: Colors.indigo.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          headerText(text, fontWeight: FontWeight.w500, color: Colors.black),
          SizedBox(width: screenWidth(context) * 0.20),
          InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.indigo.shade900,
              radius: 15,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(Icons.share_rounded,
                    size: 20, color: Colors.indigo.shade900),
              ),
            ),
            onTap: () {
              sharePng(context, _key);
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .04,
          ),
          InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.indigo.shade900,
              radius: 15,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(Icons.download_rounded,
                    size: 20, color: Colors.indigo.shade900),
              ),
            ),
            onTap: () {
              captureAndSharePng(context, _key, pop: false);
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .06,
          ),
        ],
      ),
    );
  }
}

class ReceiptDetail {
  String? title;
  String? value;
  ReceiptDetail({this.title, this.value});
}
