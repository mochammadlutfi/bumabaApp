import 'package:bumaba/Config/color.dart';
import 'package:bumaba/pages/notification_page.dart';
import 'package:bumaba/pages/transaksi/transaksi_page.dart';
import 'package:bumaba/pages/account_page.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../route_argument.dart';
import '../core/helper.dart';


import 'home_page.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomePage();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab, this.routeArgument,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomePage();
          break;
        case 1:
          widget.currentPage = TransaksiPage();
          break;
        case 2:
          widget.currentPage = NotificationPage();
          break;
        case 3:
          widget.currentPage = AccountPage();
          break;
        // case 4:
        //   widget.currentPage = AccountPage();
        //   break;
      }
    });
  }
  int currindex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        body: widget.currentPage,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconBTMAppbar(
                  "assets/icons/home.svg",
                  "Home",
                  0,
                ),
                iconBTMAppbar(
                  "assets/icons/tagihan.svg",
                  "Transaksi",
                  1,
                ),
                iconBTMAppbar(
                  "assets/icons/notification.svg",
                  "Notifikasi",
                  2,
                ),
                iconBTMAppbar(
                  "assets/icons/profile.svg",
                  "Akun",
                  3,
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Theme.of(context).accentColor,
        //   iconSize: 22,
        //   elevation: 2,
        //   backgroundColor: Colors.white,
        //   selectedIconTheme: IconThemeData(size: 28),
        //   unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
        //   currentIndex: widget.currentTab,
        //   onTap: (int i) {
        //     this._selectTab(i);
        //   },
        //   // this will be set when a new tab is tapped
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Feather.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Feather.map_pin),
        //       label: 'Near Me',
        //     ),
        //     // BottomNavigationBarItem(
        //       // icon: new Icon(Feather.ring),
        //       // label: '',
        //     // ),
        //     BottomNavigationBarItem(
        //       icon: new Icon(Feather.user),
        //       label: 'Saya',
        //     ),
        //   ],
        // ),
      ),
    );
  }

  GestureDetector iconBTMAppbar(String svgpath, String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currindex = index;
          _selectTab(index);
        });
      },
      child: Tooltip(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        message: text,
        child: Container(
          color: Colors.white,
          height: 56,
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svgpath,
                height: 19,
                color: currindex == index ? mainColor : greyicon,
              ),
              SizedBox(height: 3),
              Text(
                text,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: currindex == index ? mainColor : greyicon),
              )
            ],
          ),
        ),
      ),
    );
  }
}
