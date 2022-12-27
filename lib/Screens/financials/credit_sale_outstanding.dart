// ignore_for_file: use_build_context_synchronously

import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:dtplusmerchant/const/common_param.dart';
import 'package:dtplusmerchant/model/credit_outstanding_model.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import '../../base/base_view.dart';
import '../../const/app_strings.dart';

class CreditSaleOutStanding extends StatefulWidget {
  const CreditSaleOutStanding({super.key});

  @override
  State<CreditSaleOutStanding> createState() => _CreditSaleOutStandingState();
}

class _CreditSaleOutStandingState extends State<CreditSaleOutStanding> {
  final _custIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: normalAppBar(context, title: AppStrings.creditSaleOuts),
        body: SingleChildScrollView(child: _body(context)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BaseView<FinancialsProvider>(onModelReady: (model) async {
      await model.getCreditOutstandingDetail(context);
    }, builder: (context, financialProv, child) {
      return financialProv.isLoading
          ? Column(
          
              children: [
                SizedBox(height: screenHeight(context) * 0.35),
                Row(
                  children: [
                    SizedBox(width: screenWidth(context)*0.45,),
                   const  CircularProgressIndicator(),
                  ],
                )
              ],
            )
          : financialProv.creditOutstandingModel !=null?
          Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: _custDetailList(financialProv.creditOutstandingModel!
                        .data!.merchantCustomerMappedDetails))
              ],
            ):Container();
    });
  }

  Widget _custDetailList(List<MerchantCustomerMappedDetails>? customerList) {
    return CustomList(
        list: customerList,
        itemSpace: 15,
        child: (MerchantCustomerMappedDetails data, index) {
          return _custDetailWidget(data);
        });
  }

  // Widget _enterCustomerId(BuildContext context) {
  //   return SizedBox(
  //     width: screenWidth(context),
  //     child: TextFormField(
  //       controller: _custIdController,
  //       validator: (val) => val!.isEmpty ? 'Please Enter Customer Id' : null,
  //       keyboardType: TextInputType.number,
  //       decoration: const InputDecoration(
  //         hintText: 'Enter Customer Id',
  //       ),
  //     ),
  //   );
  // }

  Widget _custDetailWidget(MerchantCustomerMappedDetails data) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          width: screenWidth(context),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  semiBoldText(
                    AppStrings.creditSaleOuts,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ],
              ),
              Divider(color: Colors.indigo.shade400),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  column1(context, data),
                  SizedBox(width: screenHeight(context) * 0.06),
                  column2(context, data),
                ],
              ),
              SizedBox(height: screenHeight(context) * 0.02),
            ],
          ),
        ),
        _footerWidget(data)
      ],
    );
  }

  Widget column1(
    context,
    MerchantCustomerMappedDetails data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(
              'Customer Name',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            normalText(data.individualOrgName!,
                color: Colors.black, fontSize: 16),
          ],
        ),
        SizedBox(height: screenWidth(context) * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(
              'Outstanding',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            normalText(
              "₹${data.outstanding}",
              color: Colors.black,
              fontSize: 16,
            ),
          ],
        ),
      ],
    );
  }

  Widget column2(context, MerchantCustomerMappedDetails data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(
              'Credit Close Limit',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            normalText("$rupeeSign${data.creditCloseLimit}",
                color: Colors.black, fontSize: 16),
          ],
        ),
        SizedBox(height: screenWidth(context) * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(
              'CCMS Balance Status',
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
            normalText(
              data.cCMSBalanceStatus!,
              color: Colors.black,
              fontSize: 16,
            ),
          ],
        ),
      ],
    );
  }

  Widget _footerWidget(MerchantCustomerMappedDetails data) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.indigo.shade300,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          normalText(
            'CustomerId: ${data.customerId}',
            color: Colors.white,
          ),
          normalText(
            'Limit Balance: ${data.limitBalance}',
            color: Colors.white,
          ),
        ],
      ),
    );
  }

 
}
