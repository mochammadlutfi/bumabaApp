import 'package:bumaba/Modules/Simpanan/simpanan_model.dart';
import 'package:bumaba/Modules/Simpanan/simpanan_repository.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';


class SimpananController extends ControllerMVC {
  // Simpanan program;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Simpanan> simpanan = <Simpanan>[];
  Simpanan detailSimpanan;
  List<Transaksi> transaksi = <Transaksi>[];
  PagingController<int, Transaksi> pagingController = PagingController(firstPageKey: 1);
  static const _pageSize = 15;
  
  List<TagihanSimpanan> tagihanSimpanan = <TagihanSimpanan>[];
  TagihanSimpanan tagihan;
  List tagihanSelected = [];
  int totalBayar = 0;
  SimpananController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  Future<void> listenForSimpanan({String message}) async {
    simpanan.clear();
    final Stream<Simpanan> stream = await getSimpananList();
    stream.listen((Simpanan _simpanan) {
      if (!simpanan.contains(_simpanan)) {
        setState(() {
          simpanan.add(_simpanan);
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

  void listenDetailSimpanan({String slug, String message}) async {
    final Stream<Simpanan> stream = await getSimpananDetail(slug);
    stream.listen((Simpanan _data) {
      // print(_data);
      setState(() => detailSimpanan = _data);
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
  
  Future<void> listenRiwayatTransaksi(int pageKey, String slug,{ String message}) async {
    // transaksi.clear();
    // setState(() { _slug = slug; });
    List<Transaksi> transaksi = <Transaksi>[];
    final Stream<Transaksi> stream = await getRiwayatSimpanan(slug);
    stream.listen((Transaksi _transaksi) {
      if (!transaksi.contains(_transaksi)) {
        setState(() {
          transaksi.add(_transaksi);
        });
      }
    }, onError: (a) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text("Periksa Koneksi Internet"),
      ));
    }, onDone: () {
      final isLastPage = transaksi.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(transaksi);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(transaksi, nextPageKey);
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshList() async {
    setState(() {
      simpanan = <Simpanan>[];
    });

    await listenForSimpanan();
  }

  // Future<void>  refreshListTransaksi() async {
  //   setState(() {
  //     transaksi = <Transaksi>[];
  //   });

    // await listenRiwayatTransaksi(slug: _slug);
  // }

  
  void listenDetailTagihan({String slug, String message}) async {
    final Stream<TagihanSimpanan> stream = await getTagihanSimpananDetail(slug);
    stream.listen((TagihanSimpanan _data) {
      setState(() => tagihan = _data);
      print(tagihan.tunggakan);
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


  
  void ontagihanSelected(String tagihanId) async {
    if (tagihanSelected.contains(tagihanId)) {
      setState(() {
        tagihanSelected.remove(tagihanId);
        totalBayar = totalBayar- 100000;
      });
    } else {
      setState(() {
        totalBayar = totalBayar + 100000;
        tagihanSelected.add(tagihanId);
      });
    }
  }

}
