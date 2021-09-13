import 'package:bumaba/models/user_model.dart';

class Simla {
  String id;
  String tujuan;
  String jenis;
  int saldo;
  int jumlah;
  String tgl;
  String keterangan;
  User user;
  Simla();

  Simla.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      saldo = jsonMap['saldo'] != null ? jsonMap['saldo'] : 0;
      id = jsonMap['id'].toString();
      tgl = jsonMap['tgl'] != null ? jsonMap['tgl'].toString() : '';
      jenis = jsonMap['jenis'] != null ? jsonMap['jenis'].toString() : '';
      jumlah = jsonMap['jumlah'] != null ? jsonMap['jumlah'] : 0;
      user = jsonMap['user'] != null ? User.fromJSON(jsonMap['user']) : null;
    } catch (e) {

      saldo = 0;
      user = null;
      print(e);
    }
  }

  String get anggotaId => null;

  Map<String, dynamic> toMap() {
    return {
      'saldo': saldo,
    };
  }

  Map<String, dynamic> toTransferMap() {
    return {
      'anggota_id' : user.anggotaID,
      'jumlah': jumlah,
      'keterangan': keterangan,
      'secure_code' : user.securityCode,
    };
  }

  Simla.fromErrorJSON(Map<String, dynamic> jsonMap) {
    try {
      saldo = jsonMap['saldo'][0] != null ? jsonMap['saldo'][0] : '';
    } catch (e) {
      print(e);
    }
  }
}

class SimlaTransfer {
  String anggotaId;
  String anggotaNama;
  String saldo;
  int jumlah;
  String keterangan;
  String securityCode;
  SimlaTransfer();

  SimlaTransfer.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      anggotaId = jsonMap['anggota_id'].toString();
      anggotaNama = jsonMap['anggota_nama'] != null ? jsonMap['anggota_nama'].toString() : '';
      keterangan = jsonMap['keterangan'] != null ? jsonMap['keterangan'].toString() : '';
      jumlah = jsonMap['jumlah'] != null ? jsonMap['jumlah'] : 0;

    } catch (e) {
      saldo = '';
      print(e);
    }
  }

  Map<String, dynamic> transferMap() {
    return {
      'anggota_id' : anggotaId,
      'anggotaNama' : anggotaNama,
      'jumlah': jumlah,
      'keterangan': keterangan,
      'secure_code' : securityCode,
    };
  }

  SimlaTransfer.fromErrorJSON(Map<String, dynamic> jsonMap) {
    try {
      saldo = jsonMap['saldo'][0] != null ? jsonMap['saldo'][0] : '';
    } catch (e) {
      print(e);
    }
  }
}



class SimlaTopUp {
  String jumlah;
  String bank;
  String slug;
  SimlaTopUp();

  SimlaTopUp.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      jumlah = jsonMap['anggotaId'].toString();
      bank = jsonMap['saldo'];
      bank = jsonMap['slug'];
    } catch (e) {
      jumlah = '';
      bank = '';
      bank = slug;
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'jumlah': jumlah,
      'bank': bank,
      'slug': slug,
    };
  }
}


class SimlaTransaction {
  String id;
  String noTransaksi;
  String tgl;
  String method;
  String type;
  String darike;
  String jumlah;
  double amount;
  String status;
  SimlaTransaction();

  SimlaTransaction.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      noTransaksi = jsonMap['no_transaksi'] != null ? jsonMap['no_transaksi'].toString() : '';
      tgl = jsonMap['tgl'] != null ? jsonMap['tgl'].toString() : '';
      method = jsonMap['method'] != null ? jsonMap['method'].toString() : '';
      type = jsonMap['jenis_transaksi'] != null ? jsonMap['jenis_transaksi'].toString() : '';
      darike = jsonMap['type'] != null ? jsonMap['type'].toString() : '';
      jumlah = jsonMap['amount'] != null ? jsonMap['jumlah_currency'] : '';
      amount = jsonMap['amount'] != null ? double.parse(jsonMap['amount']) : 0.00;
      status = jsonMap['status'] != null ? jsonMap['status'] : '';
      
    } catch (e) {
      noTransaksi = '';
      tgl = '';
      method = '';
      type = '';
      darike = '';
      jumlah = '';
      status = '';
      amount = 0.00;
      print(e);
    }
  }

}