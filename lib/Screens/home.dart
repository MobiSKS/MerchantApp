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
import '../util/utils.dart';
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
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _merchantId(context),
                SizedBox(height: screenHeight(context) * 0.005),
                _financialgridView(context),
                SizedBox(height: screenHeight(context) * 0.005),
                _transactiongridView(context),
                SizedBox(height: screenHeight(context) * 0.005),
                _banner(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _merchantId(context) {
    return SizedBox(
      height: screenHeight(context) * 0.12,
      child: Stack(
        children: [
          Container(
            height: screenHeight(context) * 0.14,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageResources.merchantIdBg,
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          Row(
            children: [
              SizedBox(width: screenWidth(context) * 0.25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        semiBoldText(
                            'Hi ! ${Utils.checkNullValue(_sharedPref.user!.data!.objOutletDetails![0].retailOutletName!)}',
                            fontSize: 20,
                            color: Colors.white),
                        const SizedBox(height: 2),
                        semiBoldText(
                            '${AppStrings.merchantId}  ${Utils.checkNullValue(_sharedPref.user!.data!.objGetMerchantDetail![0].merchantId)}',
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: FontFamilyHelper.sourceSansRegular),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xffcecfd1), width: 1),
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
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
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
        side: const BorderSide(color: Color(0xffcecfd1), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(AppStrings.transactions,
                fontSize: 23, color: Colors.black),
            const SizedBox(height: 10),
            GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
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
      child: Column(
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
