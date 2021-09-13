import 'package:bumaba/models/transaksi_model.dart';

class Tagihan {
  String id;
  String service;
  String subService;
  int nominal;
  String jumlah;
  List<Transaksi> transaksi;
  List<String> tunggakan;
  
  Tagihan();


  Tagihan.fromJSON(Map<String, dynamic> jsonMap) {
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

class TagihanSimpananBayar{
  String id;
  String nominal;
  String jumlah;
}