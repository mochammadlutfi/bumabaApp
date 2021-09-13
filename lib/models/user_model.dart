
enum UserState { available, away, busy }

class User {
  String id;
  String nama;
  String nohp;
  String anggotaID;
  String password;
  String apiToken;
  String deviceToken;
  bool securePin;
  String initial;
  
  String securityCode;

  // used for indicate if user logged in or not
  bool auth;
  bool appaccess;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      nama = jsonMap['nama'] != null ? jsonMap['nama'] : '';
      anggotaID = jsonMap['anggota_id'] != null ? jsonMap['anggota_id'].toString() : '';
      nohp = jsonMap['no_hp'] != null ? jsonMap['no_hp'] : '';
      securePin = jsonMap['is_secure'];
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
    } catch (e) {
      print(e);
    }
  }

  User.fromErrorJSON(Map<String, dynamic> jsonMap) {
    try {
      nama = jsonMap['nama'][0] != null ? jsonMap['nama'][0] : '';
      anggotaID = jsonMap['anggota_id'][0] != null ? jsonMap['anggota_id'][0] : '';
      nohp = jsonMap['no_hp'][0] != null ? jsonMap['no_hp'][0] : '';
      password = jsonMap['password'][0] != null ? jsonMap['password'][0] : '';
      securePin = jsonMap['is_secure'][0];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["anggota_id"] = anggotaID;
    map["no_hp"] = nohp;
    map["nama"] = nama;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    return map;
  }

  Map toLogin() {
    var map = new Map<String, dynamic>();
    map["no_hp"] = nohp;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["anggota_id"] = anggotaID;
    map["no_hp"] = nohp;
    map["nama"] = nama;
    map["device_token"] = deviceToken;
    map["api_token"] = apiToken;
    map["is_secure"] = securePin;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    map["appaccess"] = this.appaccess;
    return map.toString();
  }
}
