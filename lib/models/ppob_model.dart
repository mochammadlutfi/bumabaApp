class PPOB{
  String id;
  String code;
  String operator;
  String nominal;
  String type;
  String nama;
  String expired;
  int harga;
  String phone;
  String details;
  String icon;

  PPOB();

  PPOB.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      code = jsonMap['code'] != null ? jsonMap['code'].toString() : '';
      operator = jsonMap['operator'] != null ? jsonMap['operator'].toString() : '';
      nominal = jsonMap['nominal']!= null ? jsonMap['nominal'] : '';
      type = jsonMap['type'] != null ? jsonMap['type'].toString() : '';
      nama = jsonMap['nama'] != null ? jsonMap['nama'].toString() : '';
      harga = jsonMap['harga'] != null ? jsonMap['harga'] : 0;
      phone = jsonMap['phone'] != null ? jsonMap['phone'].toString() : '';
      icon = jsonMap['icon_url'] != null ? jsonMap['icon_url'].toString() : '';
      details = jsonMap['details'] != null ? jsonMap['details'].toString() : '';
      // expired = jsonMap['list'] != null ? List.from(jsonMap['list']) : null ;
      // transaksi = jsonMap['transaksi'] != null && (jsonMap['transaksi'] as List).length > 0
      //   ? List.from(jsonMap['transaksi']).map((element) => Transaksi.fromJSON(element)).toSet().toList()
      //   : [];
      
    } catch (e) {
      id = '';
      code = '';
      operator = '';
      nominal = '';
      type = '';
      phone = '';
      harga = 0;
      icon = '';
      details = '';
      // transaksi = [];
      print("error Model");
    }
  }

}

class PLN {
  String noMeter;
  String subscriberID;
  String segmentPower;
  String name;
  
  PLN();


  PLN.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      noMeter = jsonMap['meter_no'] != null ? jsonMap['meter_no'].toString() : '';
      subscriberID = jsonMap['subscriber_id'] != null ? jsonMap['subscriber_id'].toString() : '';
      segmentPower = jsonMap['segment_power'] != null ? jsonMap['segment_power'].toString() : '';
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';
      
    } catch (e) {
      noMeter = '';
      subscriberID = '';
      segmentPower = '';
      name = '';
      print(e);
      print("error Model");
    }
  }

}