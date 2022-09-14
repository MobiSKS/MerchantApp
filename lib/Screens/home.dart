import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:flutter/material.dart';
import '../const/image_resources.dart';
import '../util/uiutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<GridOption> _gridOptions = [
    GridOption(
        optionName: AppStrings.profile, optionIcon: ImageResources.cardsImage),
    GridOption(
        optionName: AppStrings.unblockTerminalPin,
        optionIcon: ImageResources.cardsImage),
    GridOption(
        optionName: AppStrings.transactionDetails,
        optionIcon: ImageResources.transactionImage),
    GridOption(
        optionName: AppStrings.receivablePayableDetail,
        optionIcon: ImageResources.cardsImage),
    GridOption(
        optionName: AppStrings.saleReloadDEarning,
        optionIcon: ImageResources.cardsImage),
    GridOption(
        optionName: AppStrings.hpRefuelCardPaymentConfirmation,
        optionIcon: ImageResources.cardsImage),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _banner(context),
            SizedBox(height: screenHeight(context) * 0.03),
            _gridViewOptions(context),
            SizedBox(height: screenHeight(context) * 0.15),
          ],
        ),
        _bottomBanner(context),
      ],
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

  Widget _bottomBanner(BuildContext context) {
    return Image.asset(
      ImageResources.bottomBannnerImage,
      width: screenWidth(context) * 100,
      fit: BoxFit.cover,
    );
  }

  Widget _gridViewOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: List.generate(_gridOptions.length, (index) {
            return _gridWidget(context, index);
          })),
    );
  }

  Widget _gridWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (_gridOptions[index].optionName! == AppStrings.saleReloadDEarning) {
          Navigator.pushNamed(context, "/paymentAcceptance");
        } else if (_gridOptions[index].optionName! == AppStrings.profile) {
          Navigator.pushNamed(context, "/editProfile");
        } else if (_gridOptions[index].optionName! ==
            AppStrings.transactionDetails) {
          Navigator.pushNamed(context, "/transactionDetails");
        } else if (_gridOptions[index].optionName! ==
            AppStrings.receivablePayableDetail) {
          Navigator.pushNamed(context, "/receivablePayable");
        } else if (_gridOptions[index].optionName! ==
            AppStrings.unblockTerminalPin) {
          Navigator.pushNamed(context, "/erpDetail");
        } else if (_gridOptions[index].optionName! ==
            AppStrings.hpRefuelCardPaymentConfirmation) {
          Navigator.pushNamed(context, "/batchDetails");
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
              Image.asset(_gridOptions[index].optionIcon!,
                  height: screenHeight(context) * 0.04),
              const SizedBox(height: 10),
              smallText(_gridOptions[index].optionName!, size: 13.0)
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
