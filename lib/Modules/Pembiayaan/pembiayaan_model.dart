
class PembiayaanList {
  String id;
  String program;
  String limit;
  String slug;
  int jumlahTagihan;
  List<Pembiayaan> pengajuan;
  List<PembiayaanDetail> angsuran; 
  
  PembiayaanList();


  PembiayaanList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      // id = jsonMap['id'].toString();
      program = jsonMap['program'] != null ? jsonMap['program'].toString() : '';
      limit = jsonMap['limit']!= null ? jsonMap['limit'].toString() : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      jumlahTagihan = jsonMap['jumlah_tagihan'] != null ? jsonMap['jumlah_tagihan'] : 0;
      pengajuan = jsonMap['pengajuan'] != null && (jsonMap['pengajuan'] as List).length > 0
        ? List.from(jsonMap['pengajuan']).map((element) => Pembiayaan.fromJSON(element)).toSet().toList()
        : [];
      angsuran = jsonMap['angsuran'] != null && (jsonMap['angsuran'] as List).length > 0
        ? List.from(jsonMap['angsuran']).map((element) => PembiayaanDetail.fromJSON(element)).toSet().toList()
        : [];
      
    } catch (e) {
      id = '';
      program = '';
      limit = '';
      jumlahTagihan = 0;
      pengajuan = [];
      angsuran = [];
      print("error Model");
    }
  }

   Map toMap() {
    var map = new Map<String, dynamic>();
    map["program"] = program;
    map["limit"] = limit;
    map["slug"] = slug;
    return map;
  }

}



class Pembiayaan {
  String id;
  String nomor;
  String program;
  int jumlah;
  int durasi;
  int biayaAdmin;
  int bagiHasil;
  int status;
  String slug;
  String tglPengajuan;
  List<PembiayaanDetail> angsuran; 
  
  Pembiayaan();


  Pembiayaan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      nomor = jsonMap['no_pembiayaan'] != null ? jsonMap['no_pembiayaan'].toString() : '';
      program = jsonMap['program'] != null ? jsonMap['program'].toString() : '';
      jumlah = jsonMap['jumlah']!= null ? jsonMap['jumlah'] : 0;
      biayaAdmin = jsonMap['biaya_admin']!= null ? jsonMap['biaya_admin'] : 0;
      bagiHasil = jsonMap['jumlah_bunga']!= null ? jsonMap['jumlah_bunga'] : 0;
      status = jsonMap['status']!= null ? jsonMap['status'] : 0;
      durasi = jsonMap['durasi']!= null ? jsonMap['durasi'] : '';
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      tglPengajuan = jsonMap['tgl_pengajuan'] != null ? jsonMap['tgl_pengajuan'].toString() : '';

      angsuran = jsonMap['rincian'] != null && (jsonMap['rincian'] as List).length > 0
        ? List.from(jsonMap['rincian']).map((element) => PembiayaanDetail.fromJSON(element)).toSet().toList()
        : [];


    } catch (e) {
      id = '';
      nomor = '';
      program = '';
      jumlah = 0;
      durasi = 0;
      biayaAdmin = 0;
      bagiHasil = 0;
      status = 0;
      slug = '';
      tglPengajuan = '';
      print("error Model");
    }
  }

   Map toMap() {
    var map = new Map<String, dynamic>();
    map["slug"] = slug;
    map["jumlah"] = jumlah;
    map["durasi"] = durasi;
    return map;
  }

}

class PembiayaanDetail {
  String id;
  String nomor;
  String program;
  String angsuranke;
  int jumlahAngsuran;
  String tempo;
  int status;
  String slug;
  // bool isCheck;
  
  PembiayaanDetail();

  PembiayaanDetail.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      nomor = jsonMap['no_pembiayaan'] != null ? jsonMap['no_pembiayaan'].toString() : '';
      angsuranke = jsonMap['angsuran_ke'] != null ? jsonMap['angsuran_ke'].toString() : '';
      program = jsonMap['program'] != null ? jsonMap['program'].toString() : '';
      jumlahAngsuran = jsonMap['total']!= null ? jsonMap['total'] : 0;
      tempo = jsonMap['tgl_tempo']!= null ? jsonMap['tgl_tempo'] : '';
      status = jsonMap['status']!= null ? jsonMap['status'] : 0;
      slug = jsonMap['slug'] != null ? jsonMap['slug'].toString() : '';
      // isCheck = jsonMap['isCheck'] != null ? jsonMap['isCheck'] : false;
    } catch (e) {
      id = '';
      angsuranke = '';
      nomor = '';
      program = '';
      jumlahAngsuran = 0;
      tempo = '';
      slug = '';
      status = 0;
      // isCheck = false;
      print("error Model Pembiayaan Detail");
    }
  }
}

