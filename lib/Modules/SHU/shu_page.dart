
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SHUPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SHUPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SHUPageState createState() => _SHUPageState();
}

class _SHUPageState extends StateMVC<SHUPage> {
  // HomeController _con;

  // _HomePageState() : super(HomeController()) {
  //   _con = controller;                                                                                                                                          
  // }
  // @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: mainappbar("Sisa Hasil Usaha"),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}


