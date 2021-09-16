
// ignore: unused_import
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/transaksi_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



class PLNPascaPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  PLNPascaPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PLNPascaPageState createState() => _PLNPascaPageState();
}

class _PLNPascaPageState extends StateMVC<PLNPascaPage> {
  // TransaksiController _con;

  
  _PLNPascaPageState() : super(TransaksiController()) {
    // _con = controller;                                                                                                                                          
  }

  // @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _con.pagingController.dispose();
  //   super.dispose();
  // }
  
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID PELANGGAN", 
                  style: AppTheme.getTextStyle(Theme.of(context).textTheme.subtitle2,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: 700),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    style: AppTheme.getTextStyle(
                        Theme.of(context).textTheme.bodyText1,
                        letterSpacing: 0.1,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: 500),
                    decoration: InputDecoration(
                      hintText: "Masukan ID Pelanggan",
                      hintStyle: AppTheme.getTextStyle(
                          Theme.of(context).textTheme.bodyText1,
                          letterSpacing: 0.1,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: 500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xfff5f7f9),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                )
              ],
            ),

          )
        ],
      ),
    );
  }
}


