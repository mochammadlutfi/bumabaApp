import 'package:bumaba/Config/color.dart';
import 'package:bumaba/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ovo_ui/Screen/Home/HomePage.dart';
// import 'package:ovo_ui/Screen/MainPage/Component/MainBtmNavbar.dart';
// import 'package:ovo_ui/Screen/MainPage/Component/MainFAB.dart';

import 'components/main_bot_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pagecontroller;
  @override
  void initState() {
    _pagecontroller = new PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pagecontroller,
        children: [
          HomePage(),
          //insert, Deals page, Finance page, Profile page here
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.135,
        height: size.width * 0.135,
        child: FloatingActionButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/scan.svg",
            height: 21,
          ),
          backgroundColor: mainColor,
          elevation: 0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MainBottomNavBar(
        pageController: _pagecontroller,
      ),
    );
  }
}
