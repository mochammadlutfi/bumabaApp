import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../route_argument.dart';
import '../repository/payment_repository.dart' as repository;


class PaymentController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Bank> bankList = <Bank>[];
  Payment payment = new Payment();
  OverlayEntry loader;

  PaymentController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenBankList({String message}) async {
    bankList.clear();
    final Stream<Bank> stream = await repository.getBankList();
    stream.listen((Bank _bankList) {
      if (!bankList.contains(_bankList)) {
        setState(() {
          bankList.add(_bankList);
        });
      }
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text("Periksa Koneksi Internet"),
      ));
    }, onDone: () {
      if (message != null) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(message),
      ));
      }
    });
  }

  void payRequest() async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
      Overlay.of(state.context).insert(loader);
      repository.pay(payment).then((value) {
        if (value != null) {
          if(value.method == 'simla'){
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/TransaksiDetail', arguments: RouteArgument(id: value.transaksi.id, param: "sa"));
          }else{
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/PaymentConfirm', arguments: RouteArgument(param: {'id' : null, 'value' : value}));
          }
        }else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Silahkan Ulangi Kembali!"),
          ));
        }
      }).catchError((e) {
        print(e);
        loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Periksa Koneksi Internet Kamu!"),
          ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }

  void confirmPayment(String id) async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
      Overlay.of(state.context).insert(loader);
      repository.confirm(id).then((value) {
        if (value != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/TransaksiDetail', arguments: RouteArgument(id: value["id"], param: value["slug"]));
          
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Berhasil!"),
          ));
        }else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Silahkan Ulangi Kembali!"),
          ));
        }
      }).catchError((e) {
        loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Periksa Koneksi Internet Kamu!"),
          ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }

  void listenPaymentDetail({String id, String message}) async {
    final Stream<Payment> stream = await repository.getPaymentDetail(id);
    stream.listen((Payment _data) {
      setState(() => payment = _data);
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text('Periksa Koneksi Internet'),
      ));
    }, onDone: () {
        if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }


  Future<void> refreshList() async {
    setState(() {
      bankList = <Bank>[];
    });

    await listenBankList();
  }
}
