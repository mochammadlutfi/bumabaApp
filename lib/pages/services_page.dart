
import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../components/home/service_list.dart';

class ServicesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ServicesPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends StateMVC<ServicesPage> {
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.customTheme.bgLayer1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
          ),
        ),
        title: Text("Lainnya",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)
          ),
      ),
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


