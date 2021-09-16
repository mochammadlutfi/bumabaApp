
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/pages/ppob/pln_pasca.dart';
import 'package:bumaba/pages/ppob/pln_token.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class PLNPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PLNPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PLNPageState createState() => _PLNPageState();
}

class _PLNPageState extends StateMVC<PLNPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  // @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  void _setTabSelected(index){
    
    setState(() { 
      if(index == 0){
        // _con.statusTransaksi = "selesai";
        print(index);
      }else{
        // _con.statusTransaksi = "selesai";
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: AppTheme.customTheme.bgLayer1,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
            ),
          ),
          centerTitle: true,
          title: Text("Listrik PLN",
              style: AppTheme.getTextStyle(
                  Theme.of(context).textTheme.headline6,
                  fontWeight: 800)
          ),
          bottom: TabBar(
            onTap: (index) {
              _setTabSelected(index);
            },
            indicatorWeight: 10,
            controller: _tabController,
            labelPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
            ),
            labelStyle:
                const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            tabs: [
              const Text("TOKEN LISTRIK"),
              const Text("TAGIHAN LISTRIK"),
            ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PLNTokenPage(),
            PLNPascaPage(),
          ],
        ),
      );
  }
}

