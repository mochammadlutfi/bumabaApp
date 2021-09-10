import 'dart:io';

// ignore: unused_import
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Core/helper.dart';
import 'user_model.dart';
import 'user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  File image;
  OverlayEntry loader;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    initFirebase();
  }

  Future<void> initFirebase() async {
      String token = await FirebaseMessaging.instance.getToken();
      setState(() { 
        user.deviceToken = token;
      });
      
  }


  void login() async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(state.context).insert(loader);
      print(user);
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null && value.securePin == false) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/PinSetup');
        }else if(value != null && value.apiToken != null && value.securePin == true){
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/PinAccess');
        }else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("No. Ponsel Atau Password Salah"),
          ));
        }
      }).catchError((e) {
        loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Akun Kamu Belum Terdaftar!"),
          ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

}