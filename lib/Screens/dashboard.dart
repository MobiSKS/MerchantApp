import 'package:dtplusmerchant/Screens/home.dart';
import 'package:dtplusmerchant/const/app_strings.dart';
import 'package:dtplusmerchant/const/image_resources.dart';
import 'package:dtplusmerchant/side_menu.dart';
import 'package:dtplusmerchant/util/font_family_helper.dart';
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    Container(),
    const Contacts(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:
            _selectedIndex == 2 ? Colors.white : const Color(0xffe4ecf9),
        key: _scaffoldKey,
        drawer: const NavDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.indigo.shade900,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(
              fontSize: 12.0,
              fontFamily: FontFamilyHelper.sourceSansRegular,
              color: Colors.white),
          selectedLabelStyle: const TextStyle(
              fontFamily: FontFamilyHelper.sourceSansRegular,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(ImageResources.homeIcon,
                      height: 24, color: Colors.white)),
              label: AppStrings.home,
              activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    ImageResources.homeIcon,
                    height: 24,
                    color: Colors.white,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(ImageResources.statementImage,
                    height: 24, color: Colors.white),
              ),
              label: AppStrings.statement,
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(ImageResources.statementImage,
                    height: 24, color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  ImageResources.callIcon,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              label: AppStrings.contact,
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(ImageResources.callIcon,
                    height: 20, color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  ImageResources.notificationIcon,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              label: AppStrings.notification,
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(ImageResources.notificationIcon,
                    height: 20, color: Colors.white),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Column(
          children: [
            _header(context),
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: Colors.indigo.shade900,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child:
                        const Icon(Icons.menu, color: Colors.white, size: 30)),
                SizedBox(width: screenWidth(context) * 0.04),
                Image.asset(ImageResources.driveTruckPlusImage,
                    height: screenHeight(context) * 0.032),
              ],
            ),
            Row(
              children: [
                Image.asset(ImageResources.hpLogo,
                    height: screenHeight(context) * 0.05),
              ],
            )
          ],
        ),
      ),
    );
  }
}
