
import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



import 'package:bumaba/components/transaksi/transaksi_list.dart';
import 'package:bumaba/controllers/transaksi_controller.dart';

class TransaksiPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TransaksiPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends StateMVC<TransaksiPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  TransaksiController _con;

  _TransaksiPageState() : super(TransaksiController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  void _setTabSelected(index){
    
    setState(() { 
      if(index == 0){
        _con.statusTransaksi = "selesai";
        print(index);
      }else{
        _con.statusTransaksi = "selesai";
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation : 1,
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.customTheme.bgLayer1,
          centerTitle: true,
          title: Text("Catatan Transaksi",
            style: AppTheme.getTextStyle(
              Theme.of(context).textTheme.headline6,
              fontWeight: 700
            )
          ),
          bottom: TabBar(
            onTap: (index) {
              _setTabSelected(index);
            },
            indicatorWeight: 3.0,
            controller: _tabController,
            labelPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
            ),
            labelStyle:
                const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            tabs: [
              const Text("DALAM PROSES"),
              const Text("SELESAI"),
            ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            TransaksiList(status : "aktif"),
            TransaksiList(status : "selesai"),
          ],
        ),
      );
  }
}


