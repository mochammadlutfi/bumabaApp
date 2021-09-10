
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'components/transaksi_list.dart';

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
    // print(_tabController.indexIsChanging);
    // _tabController.addListener(_setActiveTabIndex);
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text("Catatan Transaksi", style: TextStyle(color: mainColor)),
          bottom: TabBar(
            onTap: (index) {
              print(index);
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


