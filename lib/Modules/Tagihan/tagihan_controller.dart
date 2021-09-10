import 'package:bumaba/Modules/Tagihan/tagihan_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import 'tagihan_model.dart';


class TagihanController extends ControllerMVC {
  // Simpanan program;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Tagihan> tagihanSimpanan = <Tagihan>[];
  Tagihan tagihan;
  List tagihanSelected = [];
  int totalBayar = 0;

  TagihanController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenListTagihanSimpanan({String message}) async {
    
    final Stream<Tagihan> stream = await listTagihanSimpanan();
    stream.listen((Tagihan _data) {
      if (!tagihanSimpanan.contains(_data)) {
        setState(() {
          tagihanSimpanan.add(_data);
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

  Future<void> refreshSimpanan() async {
    setState(() {
      tagihanSimpanan = <Tagihan>[];
    });

    await listenListTagihanSimpanan();
  }

}
