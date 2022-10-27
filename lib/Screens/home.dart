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
        optionName: AppStrings.transactionDetails,
        optionIcon: ImageResources.transactionDetail),
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
    return Container(
      color: const Color(0xffe4ecf9),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _banner(context),
                const SizedBox(height: 10),
                _merchantId(context),
                const SizedBox(height: 10),
                _financialgridView(context),
                const SizedBox(height: 10),
                _transactiongridView(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _merchantId(context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.13,
      decoration: const BoxDecoration(
          color: Color(0xff011d66),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                semiBoldText(
                    'Hi ! ${_sharedPref.user!.data!.objOutletDetails![0].retailOutletName!}',
                    fontSize: 20,
                    color: Colors.white),
                const SizedBox(height: 2),
                semiBoldText(
                    '${AppStrings.merchantId}  ${_sharedPref.user!.data!.objGetMerchantDetail![0].merchantId}',
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: FontFamilyHelper.sourceSansRegular),
              ],
            ),
            Container(
              height: screenHeight(context) * 0.035,
              width: screenWidth(context) * 0.17,
              decoration: BoxDecoration(
                  color: const Color(0xff011d66),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: semiBoldText('Edit', color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageResources.bannnerImage,
              ),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: screenHeight(context) * 0.17,
    );
  }

  Widget _financialgridView(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(AppStrings.financials, fontSize: 23, color: Colors.black),
            const SizedBox(height: 10),
            GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                children: List.generate(_financialOptions.length, (index) {
                  return _financialgridWidget(context, index);
                })),
          ],
        ),
      ),
    );
  }

  Widget _financialgridWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _navigateToFinancialScreens(index);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffe4ecf9),
            radius: 30,
            child: Center(
              child: Image.asset(_financialOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.036),
            ),
          ),
          semiBoldText(_financialOptions[index].optionName!,
              color: Colors.black, fontSize: 15, textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget _transactiongridView(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                 boldText(AppStrings.transactions, fontSize: 23, color: Colors.black),
            const SizedBox(height: 10),
            GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                children: List.generate(_transactionsOptions.length, (index) {
                  return _transactionsGridWidget(context, index);
                })),
          ],
        ),
      ),
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
      child:  Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffe4ecf9),
            radius: 30,
            child: Center(
              child: Image.asset(_transactionsOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.036),
            ),
          ),
          semiBoldText(_transactionsOptions[index].optionName!,
              color: Colors.black, fontSize: 15, textAlign: TextAlign.center)
        ],
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
    } else if (_financialOptions[index].optionName! ==
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
