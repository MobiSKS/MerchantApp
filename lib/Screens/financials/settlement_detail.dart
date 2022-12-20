// import 'package:dtplusmerchant/common/custom_list.dart';
// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart';
// import '../../base/base_view.dart';
// import '../../provider/financials_provider.dart';
// import '../../util/uiutil.dart';
// import '../../model/settlement_model.dart';
// import '../../model/batch_detail_model.dart' as batch;

// class SettlementDetail extends StatefulWidget {
//   final Data? settlementData;
//   const SettlementDetail({super.key, this.settlementData});
//   @override
//   State<SettlementDetail> createState() => _SettlementDetailState();
// }

// class _SettlementDetailState extends State<SettlementDetail> {
//   final ScreenshotController screenshotController = ScreenshotController();

//   double columnPadding = 20;
//   final GlobalKey _key1 = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: normalAppBar(context, title: 'Settlement Details'),
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(child: _body(context)),
//       ),
//     );
//   }

//   Widget _body(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         _settlementWidget(context),
//       ],
//     );
//   }

//   Widget _settlementWidget(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               semiBoldText("Summary",
//                   color: Colors.grey.shade800, fontSize: 20),
//               const SizedBox(height: 10),
//               semiBoldText(
//                   "No. of Transactions : ${widget.settlementData!.noofTransactions!}",
//                   color: Colors.grey.shade800,
//                   fontSize: 20),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   semiBoldText(
//                       "Settlement on: ${widget.settlementData!.settlementDate}",
//                       color: Colors.grey.shade800,
//                       fontSize: 20),
//                   Row(
//                     children: [
//                       shareButton(context,_key1),
//                       SizedBox(width: MediaQuery.of(context).size.width * .04),
//                       downloadButton(context,_key1)
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: screenHeight(context) * 0.03),
//             ],
//           ),
//         ),
//         Column(
//           children: [
//             _searchResultBar(context),
//           ],
//         ),
//         SizedBox(height: screenHeight(context) * 0.03),
//         BaseView<FinancialsProvider>(onModelReady: (model) async {
//           await model.getbatchtDetail(context,
//               terminalId: widget.settlementData!.terminalId!,
//               batchId: widget.settlementData!.batchId!);
//         }, builder: (context, financialpro, child) {
//           return financialpro.isLoading
//               ? Column(
//                   children: [
//                     SizedBox(height: screenHeight(context) * .03),
//                     const CircularProgressIndicator()
//                   ],
//                 )
//               : Screenshot(
//                 controller: screenshotController,
//                 child: RepaintBoundary(
//                   key: _key1,
//                   child: SizedBox(
//                       child: SingleChildScrollView(
//                           child: CustomList(
//                               list: financialpro.batchDetailModel!.data!,
//                               itemSpace: 5,
//                               child: (batch.Data data, index) {
//                                 return Column(
//                                   children: [
//                                     _listItem(context, data),
//                                     const SizedBox(height: 10),
//                                     Divider(
//                                       color: Colors.grey.shade700,
//                                       endIndent: 20,
//                                       indent: 20,
//                                     )
//                                   ],
//                                 );
//                               })),
//                     ),
//                 ),
//               );
//         })
//       ],
//     );
//   }
//   Widget _listItem(BuildContext context, batch.Data data) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             semiBoldText('Account No:',
//                 color: Colors.grey.shade900, fontSize: 18.0),
//             semiBoldText(data.cardNo!,
//                 color: Colors.grey.shade600, fontSize: 18.0),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             semiBoldText('Transaction Date/Time : ',
//                 color: Colors.grey.shade900, fontSize: 18.0),
//             semiBoldText(data.transactionDate!,
//                 color: Colors.grey.shade600, fontSize: 18.0),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             semiBoldText('Transaction Type : ',
//                 color: Colors.grey.shade900, fontSize: 18.0),
//             semiBoldText(data.transactionType!,
//                 color: Colors.grey.shade600, fontSize: 18.0),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             semiBoldText('Amount : ',
//                 color: Colors.grey.shade900, fontSize: 18.0),
//             semiBoldText('₹ ${data.invoiceAmount!}',
//                 color: Colors.grey.shade600, fontSize: 18.0),
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             semiBoldText('CCMS/Cash Balance : ',
//                 color: Colors.grey.shade900, fontSize: 18.0),
//             semiBoldText('₹ ${data.ccmsCashBalance!}',
//                 color: Colors.grey.shade600, fontSize: 18.0),
//           ],
//         ),
//       ]),
//     );
//   }

//   Widget _searchResultBar(BuildContext context) {
//     return Container(
//       width: screenWidth(context),
//       height: screenHeight(context) * 0.055,
//       color: Colors.indigo.shade100,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 30,
//             ),
//             child:
//                 semiBoldText("Transactions", color: Colors.black, fontSize: 19),
//           ),
//         ],
//       ),
//     );
//   }
// }
