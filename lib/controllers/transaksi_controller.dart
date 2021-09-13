import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../models/transaksi_model.dart';
import '../repository/transaksi_repository.dart' as repository;

class TransaksiController extends ControllerMVC {
  Transaksi detailTransaksi;
  GlobalKey<ScaffoldState> scaffoldKey;
  String statusTransaksi = 'aktif';
  List<Transaksi> transaksiListSelesai = <Transaksi>[];
  Transaksi transaksi = new Transaksi();
  OverlayEntry loader;
  bool isLoading = false;
  int page;
  PagingController<int, Transaksi> pagingController = PagingController(firstPageKey: 1);
  static const _pageSize = 15;
  

  TransaksiController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenListTransaksi(int pageKey, {String message}) async {
    // isLoading = true;
    List<Transaksi> transaksiList = <Transaksi>[];
    final Stream<Transaksi> stream = await repository.getTransaksiList(statusTransaksi, pageKey, _pageSize);
    stream.listen((Transaksi _transaksi) {
      if (!transaksiList.contains(_transaksi)) {
        setState(() {
          transaksiList.add(_transaksi);
        });
      }
    }, onError: (a) {
      print(a);
    }, onDone: () {
      final isLastPage = transaksiList.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(transaksiList);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(transaksiList, nextPageKey);
      }
  });
  }

  void listenDetailTransaksi({String id, String slug, String message}) async {
    final Stream<Transaksi> stream = await repository.getTransaksiDetail(id);
    stream.listen((Transaksi _data) {
      setState(() => detailTransaksi = _data);
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text('Periksa Koneksi Internet'),
      ));
    }, onDone: () {
      print(detailTransaksi);
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

  Future<void> refreshDetail() async {
    setState(() {
       detailTransaksi = new Transaksi();
    });

    listenDetailTransaksi();
  }


}
