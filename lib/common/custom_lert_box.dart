import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:flutter/material.dart';

import '../const/image_resources.dart';

class AlertBox extends StatelessWidget {
  final String dialogText;
  final String? FirstButtonText;
  final String? SecondButtonText;
  final Function() FirstButtonFunction;
  final Function() secondButtonFunction;
  const AlertBox({
    this.FirstButtonText = "No",
    this.SecondButtonText = "Yes",
    required this.dialogText,
    required this.FirstButtonFunction,
    required this.secondButtonFunction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .32,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 25),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                       const   SizedBox(height:15),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              dialogText,
                              textAlign: TextAlign.center,
                           style:const  TextStyle(fontFamily: FontFamilyHelper.sourceSansSemiBold)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () => FirstButtonFunction(),
                                  child: Text(
                                    FirstButtonText!,
                                    style: TextStyle(
                                        fontSize: FirstButtonText!.length <= 5
                                            ? 18
                                            : 16,
                                        color: Colors.red),
                                  )),
                              Container(
                                color: Colors.black,
                                width: .5,
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () => secondButtonFunction(),
                                  child: Text(SecondButtonText!,
                                      style: TextStyle(
                                          fontSize:
                                              SecondButtonText!.length <= 5
                                                  ? 18
                                                  : 16,
                                          color: Colors.indigo.shade900)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 6,
                    left: MediaQuery.of(context).size.width * .05,
                    right: MediaQuery.of(context).size.width * .05,
                    child: Image.asset(ImageResources.hpLogo,
                        height: size.height * .08)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
