import 'package:dtplusmerchant/Screens/profile/profile.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/preferences/shared_preference.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'Screens/auth/change_password_screen.dart';
import 'const/injection.dart';
import 'model/user_model.dart';

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

  getNameId() async {
    var user = await _sharedPref.getPrefrenceData(key: SharedPref.userDetails)
    as UserModel;
    String firstName = user.data!.objGetMerchantDetail![0].merchantName!;
    String lastName = "";
    String userId = user.data!.objGetMerchantDetail![0].merchantId!;
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
                      semiBoldText("${AppStrings.welcome} !",
                          fontSize: 20, color: Colors.white),
                      SizedBox(height: screenHeight(context) * 0.01),
                      semiBoldText(name ?? "",
                          fontSize: 24, color: Colors.white),
                      SizedBox(height: screenHeight(context) * 0.01),
                      Row(
                        children: [
                          semiBoldText('Id : ${id ?? ''}',
                              fontSize: 20, color: Colors.white),
                          const SizedBox(width: 20),
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.edit_note,
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(ImageResources.profileIcon, height: 23),
            title: semiBoldText(AppStrings.myProfile,
                color: Colors.black, fontSize: 18.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Image.asset(
              ImageResources.notificationIconM,
              height: 20,
            ),
            title: semiBoldText(AppStrings.notification,
                color: Colors.black, fontSize: 18.0),
            onTap: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const NotificationScreen()),
              // )
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading:
                Image.asset(ImageResources.changePasswortdIcon, height: 20),
            title: semiBoldText(AppStrings.changepassword,
                color: Colors.black, fontSize: 18.0),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()),
              )
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Image.asset(ImageResources.logoutIcon, height: 20),
            title: semiBoldText(AppStrings.logout,
                color: Colors.black, fontSize: 18.0),
            onTap: () async {
           logOutPopUp(context);            
            },
          ),
        ],
      ),
    );
  }
}
