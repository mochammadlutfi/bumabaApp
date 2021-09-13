import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:flutter_svg/flutter_svg.dart';


class NotificationPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  NotificationPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends StateMVC<NotificationPage> with SingleTickerProviderStateMixin {
  int selectedIndex;
  // HomeController _con;

  // _HomePageState() : super(HomeController()) {
  //   _con = controller;                                                                                                                                          
  // }
  // @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.customTheme.bgLayer1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
          ),
        ),
        title: Text("Notifikasi",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)
          ),
      ),
      backgroundColor : Theme.of(context).scaffoldBackgroundColor,
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/img/notification.svg",
                height: 100,
              ),Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Text("Tidak Ada Notifikasi Untuk Kamu",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ),
            ],
          ),
        ),
    );
  }
}


