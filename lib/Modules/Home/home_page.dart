import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

import 'home_controller.dart';
import 'components/bg_header.dart';
import 'components/info_carousel.dart';
import 'components/service_menu.dart';
import 'components/simla_service.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomePage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  HomeController _con;

  _HomePageState() : super(HomeController()) {
    _con = controller;                                                                                                                                          
  }
  @override
  void initState() {
    _con.listenSimlaSaldo();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key : _con.scaffoldKey,
      appBar: new AppBar(
          backgroundColor: bgLight,
          automaticallyImplyLeading: false,
          title: Image.asset('assets/img/logo.png',height: 36,),
        ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  PurpleBG(),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 4),
                      SimlaService(),
                      ServiceMenu(),
                      InfoPromoCarousel()
                    ],
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}
