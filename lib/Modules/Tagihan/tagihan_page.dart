
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Tagihan/tagihan_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'components/simpanan.dart';

class TagihanPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TagihanPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends StateMVC<TagihanPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  TagihanController _con;

  _TagihanPageState() : super(TagihanController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    _con.listenListTagihanSimpanan();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text("Catatan Transaksi", style: TextStyle(color: mainColor)),
          bottom: TabBar(
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
          // physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            ListTagihanSimpanan(tagihan: _con.tagihanSimpanan),

            ListTagihanSimpanan(tagihan: _con.tagihanSimpanan),
          ],
        ),
      );
  }
}


