
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'components/service_list.dart';

class ServicesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ServicesPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends StateMVC<ServicesPage> {
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
      appBar: mainappbar("Lainnya"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListService()
          ],
        ),
      ),
    );
  }
}


