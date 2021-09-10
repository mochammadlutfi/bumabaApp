

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

import 'user_controller.dart';

import 'components/user_profile.dart';
import 'components/about.dart';
import 'components/keamanan.dart';

import 'user_repository.dart';
// import '../elements/BlockButtonWidget.dart';
// import '../repository/user_repository.dart' as userRepo;
// import 'Repository/SettingRepository.dart' as settingsRepo;
// import 'elements/HomeSlider/HomeSliderWidget.dart';
// import 'elements/Category/CaregoriesCarouselWidget.dart';

// import 'elements/Toko/TokoListWidget.dart';

class AccountPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AccountPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends StateMVC<AccountPage> {
  // ignore: unused_field
  UserController _con;

  _AccountPageState() : super(UserController()) {
    _con = controller;                                                                                                                                          
  }
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        // backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        title: Text("Akun Saya",),
        // elevation: ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfile(
              nama : currentUser.value.nama,
              nohp : currentUser.value.nohp,
            ),
            // AboutApp(),
            SecurityApp(),
            AboutApp(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
              child: TextButton(
                onPressed: (){
                  logout().then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                  });
                },
                style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    backgroundColor: MaterialStateProperty.all(mainColor)
                ),
                child: Text("Keluar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
