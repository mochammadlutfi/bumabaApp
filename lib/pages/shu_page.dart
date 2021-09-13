
import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SHUPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SHUPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SHUPageState createState() => _SHUPageState();
}

class _SHUPageState extends StateMVC<SHUPage> {
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
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
        title: Text("Sisa Hasil Usaha",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}


