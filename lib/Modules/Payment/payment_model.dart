import 'package:bumaba/Modules/Pembayaran/pulsa_data_model.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';

class Bank {
  String id;
  String nama;
  String rekening;
  String kode;
  String atasNama;
  String logo;
  Bank();

  Bank.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      nama = jsonMap['nama'] != null ? jsonMap['nama'].toString() : '';
      rekening = jsonMap['no_rekening'] != null ? jsonMap['no_rekening'].toString() : '';
      kode = jsonMap['kode'] != null ? jsonMap['kode'].toString() : '';
      atasNama = jsonMap['atas_nama']!= null ? jsonMap['atas_nama'].toString() : '';
      logo = jsonMap['logo']!= null ? jsonMap['logo'].toString() : '';
    } catch (e) {
      id = '';
      nama = '';
      rekening = '';
      kode = '';
      atasNama = '';
      logo = '';
      print('Error Model Bank List');
      print(e);
    }
  }
}

class Payment {
    String id;
    String service;
    String slug;
    String bankId;
    int jumlah;
    int adminFee;
    String kode;
    String method;
    String status;
    String tgl;
    Bank bankdetail;
    Transaksi transaksi;
    List tagihanId;
    PPOB ppob;

    Payment();

    Payment.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      service = jsonMap['service'] != null ? jsonMap['service'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      bankId = jsonMap['bank_id'] != null ? jsonMap['bank_id'].toString() : '';
      jumlah = jsonMap['jumlah'] != null ? jsonMap['jumlah'] : 0;
      kode = jsonMap['code']!= null ? jsonMap['code'].toString() : '';
      tgl = jsonMap['tgl_bayar'] != null ? jsonMap['tgl_bayar'].toString() : '';
      method = jsonMap['method'] != null ? jsonMap['method'].toString() : '';
      status = jsonMap['status'] != null ? jsonMap['status'].toString() : '';
      adminFee = jsonMap['admin_fee']!= null ? jsonMap['admin_fee'] : 0;

      bankdetail = jsonMap['bank'] != null ? Bank.fromJSON(jsonMap['bank']) : null;
      transaksi = jsonMap['transaksi'] != null ? Transaksi.fromJSON(jsonMap['transaksi']) : null;

    } catch (e) {
      id = '';
      jumlah = 0;
      status = '';
      kode = '';
      service = '';
      tgl = '';
      method = '';
      adminFee = 0;
      transaksi = null;
      bankdetail = null;
      print(e);
      print('error Model Payment');
    }
  }
    

    Map toMap() {
    var map = new Map<String, dynamic>();
    map["service"] = service;
    map["slug"] = slug;
    map["jumlah"] = jumlah;
    map["bank"] = bankId;
    map["tagihan_id"] = tagihanId;
    return map;
  }
}
