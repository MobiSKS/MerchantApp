import 'package:dtplusmerchant/Screens/auth/forgot_password_screen.dart';
import 'package:dtplusmerchant/Screens/notification_screen.dart';
import 'package:dtplusmerchant/Screens/profile/edit_profile.dart';
import 'package:dtplusmerchant/Screens/receipt.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';

import 'const/injection.dart';
import 'preferences/shared_preference.dart';
import 'util/utils.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();

  String? name;
  String? id;

  @override
  void initState() {
    super.initState();
    getNameId();
  }

  getNameId() {
    String firstName = "";
    String lastName = "";
    String userId = "";
    setState(() {
      name = "$firstName $lastName";
      id = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo.shade900,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight(context) * 0.02),
                      headerText(AppStrings.welcome, fontSize: 21),
                      SizedBox(height: screenHeight(context) * 0.01),
                      headerText(name!,
                          fontSize: 24, fontWeight: FontWeight.bold),
                      SizedBox(height: screenHeight(context) * 0.01),
                      Row(
                        children: [
                          headerText('Id : $id', fontSize: 20),
                          const SizedBox(width: 20),
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.edit_note,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: screenWidth(context) * 0.109)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(ImageResources.profileIcon, height: 23),
            title: headerText(AppStrings.myProfile, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Image.asset(ImageResources.notificationIcon, height: 20),
            title: headerText(AppStrings.notification, color: Colors.black),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              )
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading:
                Image.asset(ImageResources.changePasswortdIcon, height: 20),
            title: headerText(AppStrings.changepassword, color: Colors.black),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ForgotPassword(isChangePassword: true)),
              )
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Image.asset(ImageResources.logoutIcon, height: 20),
            title: headerText(AppStrings.logout, color: Colors.black),
            onTap: () => {Utils.logout(context)},
          ),
        ],
      ),
    );
  }
}
