import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

class SlideButton extends StatelessWidget {
  final PageController pageController;
  final int pageIndex;
  final String labelFirst;
  final String labelSecond;
  final double? textSize;

  const SlideButton({
    Key? key,
    required this.pageController,
    required this.pageIndex,
    required this.labelFirst,
    required this.labelSecond,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      width: screenWidth(context)*0.72,
      decoration: BoxDecoration(
          color: Colors.indigo.shade900,
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                pageController.animateToPage(0,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 500));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: pageIndex == 0 ? Colors.white : Colors.indigo.shade900,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  labelFirst,
                  textAlign: TextAlign.center,
                  style: pageIndex == 0
                      ? TextStyle(
                          color: Colors.indigo.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)
                      : const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                pageController.animateToPage(1,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 500));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: pageIndex == 1 ? Colors.white : Colors.indigo.shade900,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  labelSecond,
                  textAlign: TextAlign.center,
                  style: pageIndex == 1
                      ? TextStyle(
                          color: Colors.indigo.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)
                      : const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
