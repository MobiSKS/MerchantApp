import 'package:dtplusmerchant/common/custom_list.dart';
import 'package:flutter/material.dart';
import '../const/app_strings.dart';
import '../util/uiutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {
  final List<Notification> _noti = [
    Notification('This is notification', '7/09/2022', isRead: true),
    Notification('This is notification', '7/09/2022', isRead: true),
    Notification('This is notification', '7/09/2022', isRead: false)
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          header(context),
          SizedBox(height: screenHeight(context) * 0.02),
          title(context, AppStrings.notification),
          SizedBox(height: screenHeight(context) * 0.06),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: _body(context))
        ],
      )),
    );
  }

  Widget _body(BuildContext context) {
    return CustomList(
      list: _noti,
      itemSpace: 10,
      child: (Notification data, index) {
        return Column(
          children: [
            _notificationCard(data),
            const SizedBox(height: 10),
            const Divider(color: Colors.blueGrey)
          ],
        );
      },
    );
  }

  Widget _notificationCard(Notification data) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            boldText(data.date!, color: Colors.black),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: screenHeight(context) * 0.8,
                color: Colors.red,
                width: 2),
            const    SizedBox(width:20),
          normalText(data.notif!)
          ],
        )
      ],
    );
  }
}

class Notification {
  String? notif;
  String? date;
  late bool isRead;

  Notification(this.notif, this.date, {isRead = false});
}
