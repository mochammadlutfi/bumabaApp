import 'dart:async';

import 'package:bumaba/Config/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'splash_controller.dart';
import '../repository/user_repository.dart' as userRepo;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}


class _SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  _SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _loadWidget();
    
    Firebase.initializeApp().whenComplete(() { 
      setState(() {});
    });
    userRepo.getCurrentUser();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (userRepo.currentUser.value.id != null && userRepo.currentUser.value.securePin == false) {
      Navigator.of(context).pushReplacementNamed('/PinSetup');
    }else if (userRepo.currentUser.value.id != null && userRepo.currentUser.value.securePin == true) {
      Navigator.of(context).pushReplacementNamed('/PinAccess');
    }else{
      Navigator.of(context).pushReplacementNamed('/Login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/img/logo_hor.png',
                        height: 300,
                        width: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(mainColor),
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}