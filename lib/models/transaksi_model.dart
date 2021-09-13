import 'package:bumaba/models/payment_model.dart';

class Transaksi {
  String id;
  String nomor;
  String tgl;
  String jenis;
  String service;
  String darike;
  int jumlah;
  int hasPaid;

  Payment payment;

  Transaksi();

  Transaksi.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      nomor = jsonMap['nomor'] != null ? jsonMap['nomor'].toString() : '';
      tgl = jsonMap['tgl'] != null ? jsonMap['tgl'].toString() : '';
      jenis = jsonMap['jenis_transaksi'] != null ? jsonMap['jenis_transaksi'].toString() : '';
      service = jsonMap['service'] != null ? jsonMap['service'].toString() : '';
      jumlah = jsonMap['total'] != null ? jsonMap['total'] : 0;
      hasPaid = jsonMap['status'] != null ? jsonMap['status'] : 0;

      payment = jsonMap['pembayaran'] != null ? Payment.fromJSON(jsonMap['pembayaran']) : null;
      
    } catch (e) {
      id = '';
      nomor = '';
      tgl = '';
      jenis = '';
      service = '';
      jumlah = 0;
      hasPaid = 0;
      payment = null;
      print(e);
      print('error Model Transaksi');
    }
  }

  Map toPayMap() {
    var map = new Map<String, dynamic>();
    map["jumlah"] = jumlah;
    // map["bank"] = bankId;
    return map;
  }

  @override
  String toString() {
    return this.toPayMap().toString();
  }
}

class TransaksiItem {
  String nama;
  String nominal;
  TransaksiItem();

  TransaksiItem.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      nama = jsonMap['nama'] != null ? jsonMap['nama'].toString() : '';
      nominal = jsonMap['no_rekening'] != null ? jsonMap['no_rekening'].toString() : '';
    } catch (e) {
      nama = '';
      nominal = '';
      print('Error Item List');
      print(e);
    }
  }
}
