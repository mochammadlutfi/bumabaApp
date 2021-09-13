import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/models/simla_model.dart';
import 'package:bumaba/models/simpanan_model.dart';
import 'package:bumaba/models/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../route_argument.dart';
import '../Modules/Simla/simla_repository.dart' as repository;


class SimlaController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formTopUp;
  GlobalKey<FormState> formTransfer;
  List<Transaksi> riwayat = <Transaksi>[];
  Simpanan detailSimpanan;
  int nominal;
  String amount;
  Simla simla = new Simla();
  
  OverlayEntry loader;
  SimlaController() {
    formTopUp = new GlobalKey<FormState>();
    formTransfer = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenRiwayatTransaksi({String message}) async {
    riwayat.clear();
    final Stream<Transaksi> stream = await repository.getRiwayat();
    stream.listen((Transaksi _transaksi) {
      if (!riwayat.contains(_transaksi)) {
        setState(() {
          riwayat.add(_transaksi);
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

  void simpanTopUp() async{
    FocusScope.of(state.context).unfocus();
    if (formTopUp.currentState.validate()) {
      if(nominal < 10000){
        Fluttertoast.showToast(msg: 'Jumlah Minimal Isi Saldo Rp10.000');
      }else{
        Map parameter = {
          'nominal' : nominal, 
          'slug' : 'deposit', 
          'service' : 'sukarela',
          'title' : 'Isi Saldo Simpanan Sukarela'
        };
        Navigator.of(scaffoldKey.currentContext).pushNamed('/PaymentMethod', arguments: RouteArgument(param : parameter));
      }
    }
  }
 
  void validateAnggota(String phone, String avatar) async{
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
    repository.cekAnggota(phone).then((value) {
      if (value != null) {
        setState(() {
          simla.user = value;
          simla.user.initial = avatar;
        });
        Navigator.of(scaffoldKey.currentContext).pushNamed('/SimlaTransferInfo', arguments: RouteArgument(param : simla));
      }
    }).catchError((e) {
      loader.remove();
      showModalBottomSheet(
        context: state.context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: (){
                      Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                  ),
                ),
                Center(
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/img/notification.svg",
                      height: 180,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void confirmTransfer() async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
    repository.transfer(simla).then((value) {
      if (value != null) {
        listenSimlaSaldo();
        Navigator.of(scaffoldKey?.currentContext).pushReplacementNamed('/TransaksiDetail', arguments: new RouteArgument(id: value, param : 'sukarela'));
        // Navigator.of(state.context).pushNamedAndRemoveUntil('/TransaksiDetail', ModalRoute.withName('/Pages'), arguments: new RouteArgument(id: value, param : 'sukarela'));
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

  Future<void> listenSimlaSaldo({String message}) async {
    repository.getSimlaSaldo().then((value) {
      if (value != null) {
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> refreshList() async {
    setState(() {
      riwayat = <Transaksi>[];
    });

    await listenRiwayatTransaksi();
  }
}
