import 'package:dtplusmerchant/Screens/financials/batch_details.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import '../const/image_resources.dart';
import '../util/uiutil.dart';
import '../util/utils.dart';
import 'financials/settlement_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<GridOption> _financialOptions = [
    GridOption(
        optionName: AppStrings.summary, optionIcon: ImageResources.summaryIcon),
    GridOption(
        optionName: AppStrings.settlements,
        optionIcon: ImageResources.settlementIcon),
    GridOption(
        optionName: AppStrings.receivablePayableDetail,
        optionIcon: ImageResources.recieveIcon),
    GridOption(
        optionName: AppStrings.earningDetails,
        optionIcon: ImageResources.earningIcon),
    GridOption(
        optionName: AppStrings.creditSaleOuts,
        optionIcon: ImageResources.creditSale),
    GridOption(
        optionName: AppStrings.cardBalance,
        optionIcon: ImageResources.cardBalance),
  ];
  final List<GridOption> _transactionsOptions = [
    GridOption(
        optionName: AppStrings.sale, optionIcon: ImageResources.saleIcon),
    GridOption(
        optionName: AppStrings.payMerchant,
        optionIcon: ImageResources.payMerchantIcon),
    GridOption(
        optionName: AppStrings.creditSaleComplete,
        optionIcon: ImageResources.creditSettle),
    GridOption(
        optionName: AppStrings.cardFee, optionIcon: ImageResources.cardFee),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _banner(context),
                SizedBox(height: screenHeight(context) * 0.08),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: headerText(AppStrings.financials,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: screenHeight(context) * 0.02),
                _financialgridView(context),
                SizedBox(height: screenHeight(context) * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: headerText(AppStrings.transactions,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: screenHeight(context) * 0.02),
                _transactiongridView(context)
              ],
            ),
          ],
        ),
        Positioned(
            top: screenHeight(context) * 0.14,
            left: screenWidth(context) * 0.05,
            child: _merchantId(context))
      ],
    );
  }

  Widget _merchantId(context) {
    return Container(
      width: screenWidth(context) * 0.90,
      height: screenHeight(context) * 0.07,
      decoration: BoxDecoration(
          color: Colors.indigo.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headerText(Utils.outletName,
              fontWeight: FontWeight.bold, color: Colors.black),
          headerText('Merchant Id  ${Utils.merchantId}',
              fontWeight: FontWeight.normal, color: Colors.black),
        ],
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.17,
      child: Image.asset(
        ImageResources.bannnerImage,
        width: screenWidth(context) * 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _financialgridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(_financialOptions.length, (index) {
            return _financialgridWidget(context, index);
          })),
    );
  }

  Widget _financialgridWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (_financialOptions[index].optionName! == AppStrings.settlements) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettlementScreen()),
          );
        } else if (_financialOptions[index].optionName! ==
            AppStrings.earningDetails) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BatchDetails()),
          );
        }
      },
      child: Container(
        height: screenHeight(context) * 0.12,
        width: screenWidth(context) * 0.15,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_financialOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.04),
              const SizedBox(height: 10),
              smallText(_financialOptions[index].optionName!, size: 15.0)
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactiongridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(_transactionsOptions.length, (index) {
            return _transactionsGridWidget(context, index);
          })),
    );
  }

  Widget _transactionsGridWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (_transactionsOptions[index].optionName! == AppStrings.sale) {
          Navigator.pushNamed(context, "/paymentAcceptance");
        }
      },
      child: Container(
        height: screenHeight(context) * 0.12,
        width: screenWidth(context) * 0.15,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_transactionsOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.04),
              const SizedBox(height: 10),
              smallText(_transactionsOptions[index].optionName!, size: 15.0)
            ],
          ),
        ),
      ),
    );
  }
}

class GridOption {
  String? optionName;
  String? optionIcon;

  GridOption({this.optionIcon, this.optionName});
}
