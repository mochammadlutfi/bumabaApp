
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

// Simla
import '../../Modules/Simla/simla_model.dart';
import '../../Modules/Simla/simla_repository.dart';

// ignore: unused_import
import '../../Core/helper.dart';

class HomeController extends ControllerMVC {
  Simla simla;
  int quantity = 1;
  double total = 0;
  int saldoSimla = 0;
  GlobalKey<ScaffoldState> scaffoldKey;

  Future<void> listenSimlaSaldo({String message}) async {
    getSimlaSaldo().then((value) {
      if (value != null) {
        setState(() {
          saldoSimla = value;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> refreshHome() async {
    setState(() {
      saldoSimla = 0;
    });

    await listenSimlaSaldo();
  }
}
