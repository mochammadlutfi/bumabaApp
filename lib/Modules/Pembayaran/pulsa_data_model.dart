class PulsaData{
  String id;
  String code;
  String operator;
  String nominal;
  String type;
  String nama;
  String expired;
  int harga;
  String details;

  PulsaData();

  PulsaData.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      code = jsonMap['code'] != null ? jsonMap['code'].toString() : '';
      operator = jsonMap['operator'] != null ? jsonMap['operator'].toString() : '';
      nominal = jsonMap['nominal']!= null ? jsonMap['nominal'] : '';
      type = jsonMap['jumlah'] != null ? jsonMap['jumlah'].toString() : '';
      nama = jsonMap['nama'] != null ? jsonMap['nama'].toString() : '';
      harga = jsonMap['harga'] != null ? jsonMap['harga'] : 0;
      details = jsonMap['details'] != null ? jsonMap['details'].toString() : '';
      // expired = jsonMap['list'] != null ? List.from(jsonMap['list']) : null ;
      // transaksi = jsonMap['transaksi'] != null && (jsonMap['transaksi'] as List).length > 0
      //   ? List.from(jsonMap['transaksi']).map((element) => Transaksi.fromJSON(element)).toSet().toList()
      //   : [];
      
    } catch (e) {
      id = '';
      code = '';
      nominal = '';
      type = '';
      operator = '';
      details = '';
      harga = 0;
      // transaksi = [];
      print("error Model");
    }
  }


}