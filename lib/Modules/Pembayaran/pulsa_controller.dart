import 'package:bumaba/Modules/Pembayaran/pulsa_data_model.dart';
import 'package:bumaba/Modules/User/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'PulsaDataRepository.dart';


class PulsaController extends ControllerMVC {

  String nohp;
  String operator = 'Operator';
  TextEditingController nohpField = TextEditingController();
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  List<PPOB> pulsaDataList = <PPOB>[];
  Map param = {};
  String type;
  PulsaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> listenForListPulsa({String type, String message}) async {
    pulsaDataList.clear();
    final Stream<PPOB> stream = await getListPulsa(type, operator);
    stream.listen((PPOB _data) {
      if (!pulsaDataList.contains(_data)) {
        setState(() {
          pulsaDataList.add(_data);
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

  void listenOperator(){
    nohp = '0'+currentUser.value.nohp;
    cekOperator(nohp);
  }

  void cekOperator(String value){
      RegExp telkomsel = new  RegExp(r'^(\\+62|\\+0|0|62)8(1[123]|52|53|21|22|23)$');
      RegExp indosat = new  RegExp(r'(^08(14|15|16|55|56|57|58)$/)');
      RegExp xl = new  RegExp(r'(/^08(14|15|16|55|56|57|58)$/)');
      RegExp axis = new  RegExp(r'(/^08(14|15|16|55|56|57|58)$/)');
      RegExp three = new  RegExp(r'^(\\+62|\\+0|0|62)8(9[56789])$');

      if(value.length >= 4){
      // print(value);
        String noHP = value.substring(0, 4);
        if(telkomsel.hasMatch(noHP)){
          type != 'data' ? 
          operator = 'telkomsel' :
          operator = 'telkomsel_paket_internet';
        }else if(indosat.hasMatch(noHP)){
          type != 'data' ? 
          operator = 'indosat' :
          operator = 'indosat_paket_internet';
        }else if(xl.hasMatch(noHP)){
          type != 'data' ? 
          operator = 'xl' :
          operator = 'xl_paket_internet';
        }else if(axis.hasMatch(noHP)){
          type != 'data' ? 
          operator = 'axis' :
          operator = 'axis_paket_internet';
        }else if(three.hasMatch(noHP)){
          type != 'data' ? 
          operator = 'three' :
          operator = 'tri_paket_internet';
        }else{
          operator = 'Operator';
        }
      }
  }


  

}