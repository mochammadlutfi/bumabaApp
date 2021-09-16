import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

// Simla
import '../models/simla_model.dart';
import '../repository/simla_repository.dart';


import '../models/slide_model.dart';
import '../repository/slide_repository.dart';


class HomeController extends ControllerMVC {
  Simla simla;
  int quantity = 1;
  double total = 0;
  int saldoSimla = 0;
  List<Slide> slides = <Slide>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  HomeController() {
    listenSimlaSaldo();
    listenForSlides();
  }

  Future<void> listenForSlides() async {
    final Stream<Slide> stream = await getSlides();
    stream.listen((Slide _slide) {
      setState(() => slides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


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
      slides = <Slide>[];
      saldoSimla = 0;
    });

    await listenSimlaSaldo();
    await listenForSlides();
  }
}
