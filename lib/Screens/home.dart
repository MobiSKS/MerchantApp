import 'package:dtplusmerchant/Screens/financials/batch_details.dart';
import 'package:dtplusmerchant/Screens/financials/card_balance_screen.dart';
import 'package:dtplusmerchant/Screens/financials/credit_sale_outstanding.dart';
import 'package:dtplusmerchant/Screens/financials/receivable_payable.dart';
import 'package:dtplusmerchant/Screens/financials/transaction_details.dart';
import 'package:dtplusmerchant/Screens/transactions/card_fee.dart';
import 'package:dtplusmerchant/Screens/transactions/credit_sale_complete.dart';
import 'package:dtplusmerchant/Screens/transactions/pay_merchant.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';
import '../const/image_resources.dart';
import '../const/injection.dart';
import '../preferences/shared_preference.dart';
import '../util/uiutil.dart';
import 'financials/settlement_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final SharedPref _sharedPref = Injection.injector.get<SharedPref>();
  final List<GridOption> _financialOptions = [
    GridOption(
        optionName: AppStrings.transactionDetails, optionIcon: ImageResources.summaryIcon),
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
      child: SingleChildScrollView(child: _body(context)),
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
                SizedBox(height: screenHeight(context) * 0.07),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: boldText(AppStrings.financials,
                      fontSize: 23, color: Colors.black),
                ),
                SizedBox(height: screenHeight(context) * 0.02),
                _financialgridView(context),
                SizedBox(height: screenHeight(context) * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: boldText(AppStrings.transactions,
                      fontSize: 23,
                      color: Colors.black),
                ),
                SizedBox(height: screenHeight(context) * 0.01),
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
      height: screenHeight(context) * 0.09,
      decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          boldText(_sharedPref.user!.data!.objOutletDetails![0].retailOutletName!, fontSize: 20, color: Colors.black),
          const SizedBox(height: 5),
          semiBoldText('${AppStrings.merchantId}  ${_sharedPref.user!.data!.objGetMerchantDetail![0].merchantId}',
              fontSize: 18,
              color: Colors.black,
              fontFamily: FontFamilyHelper.sourceSansRegular),
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
        _navigateToFinancialScreens(index);
      },
      child: Container(
        height: screenHeight(context) * 0.12,
        width: screenWidth(context) * 0.17,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blueGrey.shade100),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_financialOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.036),
              const SizedBox(height: 6),
              semiBoldText(_financialOptions[index].optionName!,
                  color: Colors.black,
                  fontFamily: FontFamilyHelper.sourceSansBold,
                  fontSize:_financialOptions[index].optionName ==AppStrings.settlements ||_financialOptions[index].optionName ==AppStrings.creditSaleOuts?13.5: 15.0,
                  textAlign: TextAlign.center)
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
        } else if (_transactionsOptions[index].optionName! ==
            AppStrings.cardFee) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CardFee()),
          );
        } else if (_transactionsOptions[index].optionName! ==
            AppStrings.payMerchant) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PayMerchant()),
          );
        } else if (_transactionsOptions[index].optionName! ==
            AppStrings.creditSaleComplete) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreditSaleComplete()),
          );
        }
      },
      child: Container(
        height: screenHeight(context) * 0.12,
      width: screenWidth(context) * 0.15,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: Colors.blueGrey.shade100),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_transactionsOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.038),
              const SizedBox(height: 10),
                semiBoldText(_transactionsOptions[index].optionName!,
                  color: Colors.black,
                  fontFamily: FontFamilyHelper.sourceSansBold,
                  fontSize: 15.0,
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFinancialScreens(int index) {
    
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
    } else if (_financialOptions[index].optionName! == AppStrings.cardBalance) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CardBalanceScreen()),
      );
    } else if (_financialOptions[index].optionName! ==
        AppStrings.creditSaleOuts) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreditSaleOutStanding()),
      );
    } else if (_financialOptions[index].optionName! ==
        AppStrings.transactionDetails) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TransactionDetails()),
      );
    }else if (_financialOptions[index].optionName! ==
        AppStrings.receivablePayableDetail) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReceivablePayable()),
      );
    }
  }
}

class GridOption {
  String? optionName;
  String? optionIcon;

  GridOption({this.optionIcon, this.optionName});
}
