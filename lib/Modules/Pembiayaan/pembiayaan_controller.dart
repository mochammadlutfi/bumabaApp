import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import 'pembiayaan_model.dart';
import 'pembiayaan_repository.dart' as repository;
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';


class PembiayaanController extends ControllerMVC {
  // Simpanan program;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formPembiayaanTunai;
  List<PembiayaanList> pembiayaanList = <PembiayaanList>[];
  PembiayaanList listDetail;

  
  Pembiayaan detail;
  List<Transaksi> transaksi = <Transaksi>[];
  Pembiayaan pengajuan = new Pembiayaan();

  
  List<PembiayaanDetail> tagihanList = <PembiayaanDetail>[];
  
  OverlayEntry loader;
  double admin, angsuranPokok,bagiHasil,diterima,jumlahAngsuran;

  
  List tagihanSelected = [];


  PembiayaanController() {
    formPembiayaanTunai = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenForPembiayaan({String message}) async {
    
    final Stream<PembiayaanList> stream = await repository.getPembiayaanList();
    stream.listen((PembiayaanList _pembiayaan) {
      if (!pembiayaanList.contains(_pembiayaan)) {
        setState(() {
          pembiayaanList.add(_pembiayaan);
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

  void listenPembiayaanListDetail({String slug, String message}) async {
    final Stream<PembiayaanList> stream = await repository.getPembiayaanListDetail(slug);
    stream.listen((PembiayaanList _data) {
      setState(() => listDetail = _data);
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


  void listenPembiayaanDetail({String slug, String message, String id}) async {
    final Stream<Pembiayaan> stream = await repository.getPembiayaanDetail(slug, id);
    stream.listen((Pembiayaan _data) {
      setState(() => detail = _data);
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


  Future<void> listenForTagihanPembiayaan({String slug, String message}) async {
    
    final Stream<PembiayaanDetail> stream = await repository.getTagihanPembiayaanList(slug);
    stream.listen((PembiayaanDetail _tagihan) {
      if (!tagihanList.contains(_tagihan)) {
        setState(() {
          tagihanList.add(_tagihan);
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


  void hitungPengajuanTunai(){
      pengajuan.jumlah = pengajuan.jumlah == null ? 200000 : pengajuan.jumlah;
      pengajuan.durasi = pengajuan.durasi == null ? 2 : pengajuan.durasi;
      admin = pengajuan.jumlah * (1 / 100);
      angsuranPokok = pengajuan.jumlah / pengajuan.durasi;
      bagiHasil = pengajuan.jumlah * 3.95 / 100;
      diterima = pengajuan.jumlah-admin;
      jumlahAngsuran = angsuranPokok + bagiHasil;
  }

  void simpanPengajuan() async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    if (formPembiayaanTunai.currentState.validate()) {
      formPembiayaanTunai.currentState.save();
      Overlay.of(state.context).insert(loader);
      repository.pengajuanTunai(pengajuan).then((value) {
        if (value != null && value.nomor != null) {
          if(value.slug == 'tunai'){
            ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
              content: Text("Tunai"),
            ));
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/PembiayaanTunaiDetail', arguments: RouteArgument(id: value.id));
          }
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

  

  void ontagihanSelected(bool selected, String tagihanId) async {
    if (selected == true) {
      setState(() {
        tagihanSelected.add(tagihanId);
      });
    } else {
      setState(() {
        tagihanSelected.remove(tagihanId);
      });
    }
  }
  
  // Future<void> listenRiwayatTransaksi({String slug, String message}) async {
  //   transaksi.clear();
    
  //   setState(() { _slug = slug; });
  //   final Stream<Transaksi> stream = await getRiwayatSimpanan(slug);
  //   stream.listen((Transaksi _transaksi) {
  //     if (!transaksi.contains(_transaksi)) {
  //       setState(() {
  //         transaksi.add(_transaksi);
  //       });
  //     }
  //   }, onError: (a) {
  //     print(a);
  //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //       content: Text("Periksa Koneksi Internet"),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //       content: Text(message),
  //     ));
  //     }
  //   });
  // }

  Future<void> refreshList() async {
    setState(() {
      pembiayaanList = <PembiayaanList>[];
    });

    await listenForPembiayaan();
  }

  // void listenDetailPembiayaan({String slug}) {}
}
