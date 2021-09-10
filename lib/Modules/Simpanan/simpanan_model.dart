import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';

class Simpanan {
  String id;
  String program;
  String saldo;
  String slug;
  List<Transaksi> transaksi;
  TagihanSimpanan tagihan;
  Simpanan();


  Simpanan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      // id = jsonMap['id'].toString();
      program = jsonMap['program'] != null ? jsonMap['program'].toString() : '';
      saldo = jsonMap['saldo']!= null ? jsonMap['saldo'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      transaksi = jsonMap['transaksi'] != null && (jsonMap['transaksi'] as List).length > 0
        ? List.from(jsonMap['transaksi']).map((element) => Transaksi.fromJSON(element)).toSet().toList()
        : [];
      tagihan = jsonMap['tagihan'] != null ? TagihanSimpanan.fromJSON(jsonMap["tagihan"]) : null;
      
    } catch (e) {
      id = '';
      program = '';
      saldo = '';
      transaksi = [];
      print("error Model");
    }
  }

   Map toMap() {
    var map = new Map<String, dynamic>();
    map["program"] = program;
    map["saldo"] = saldo;
    map["slug"] = slug;
    return map;
  }

}

class TagihanSimpanan {
  String id;
  String service;
  String subService;
  int nominal;
  String jumlah;
  List<Transaksi> transaksi;
  List<String> tunggakan;
  
  TagihanSimpanan();


  TagihanSimpanan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      service = jsonMap['service'] != null ? jsonMap['service'].toString() : '';
      subService = jsonMap['subService'] != null ? jsonMap['subService'].toString() : '';
      nominal = jsonMap['nominal']!= null ? jsonMap['nominal'] : '';
      jumlah = jsonMap['jumlah'] != null ? jsonMap['jumlah'].toString() : '';
      tunggakan = jsonMap['list'] != null ? List.from(jsonMap['list']) : null ;
      transaksi = jsonMap['transaksi'] != null && (jsonMap['transaksi'] as List).length > 0
        ? List.from(jsonMap['transaksi']).map((element) => Transaksi.fromJSON(element)).toSet().toList()
        : [];
      
    } catch (e) {
      id = '';
      service = '';
      nominal = 0;
      transaksi = [];
      print("error Model");
    }
  }

   Map toMap() {
    var map = new Map<String, dynamic>();
    map["service"] = service;
    map["nominal"] = nominal;
    map["jumlah"] = jumlah;
    return map;
  }

}
