import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/models/payment_model.dart';
import 'package:bumaba/models/ppob_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../models/transaksi_model.dart';
import '../repository/PulsaDataRepository.dart' as repo;
import 'package:bumaba/repository/payment_repository.dart' as payRepo;

import '../route_argument.dart';

class PPOBController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  bool isLoading = false;
  List<PPOB> ppobList = <PPOB>[];
  int page;
  PPOB ppob = new PPOB();
  PLN pln = new PLN();
  bool plnError = false;
  Payment payment = new Payment();
  List<Bank> bankList = <Bank>[];
  PagingController<int, Transaksi> pagingController = PagingController(firstPageKey: 1);
  

  PPOBController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void topUp() async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
    payRepo.pay(payment).then((value) {
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


  Future<void> listenPLN({String message}) async {
    ppobList.clear();
    final Stream<PPOB> stream = await repo.getListPulsa("pln", "pln");
    stream.listen((PPOB _data) {
      if (!ppobList.contains(_data)) {
        setState(() {
          ppobList.add(_data);
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

  void listenPLNID(String phone) async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
    await repo.getPLNID(phone).then((value) {
      if (value != null) {
        setState(() {
          pln = value;
          plnError = false;
        });
      }
    }).catchError((e) {
      loader.remove();
      plnError = true;
    });
    Helper.hideLoader(loader);
  }



  Future<void> listenBankList({String message}) async {
    bankList.clear();
    final Stream<Bank> stream = await payRepo.getBankList();
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


  Future<void> refreshList() async {
    setState(() {
      page = 1;
    });
    // transaksiList.clear();
    // repository.getTransaksiList(statusTransaksi, page);
  }

}
