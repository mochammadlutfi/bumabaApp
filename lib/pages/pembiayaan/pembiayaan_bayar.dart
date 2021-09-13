import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Config/color.dart';


import '../../route_argument.dart';
import '../../controllers/pembiayaan_controller.dart';

// ignore: must_be_immutable
class PembiayaanBayarPage extends StatefulWidget {
  RouteArgument routeArgument;

  PembiayaanBayarPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PembiayaanBayarPageState createState() {
    return _PembiayaanBayarPageState();
  }
}

class _PembiayaanBayarPageState extends StateMVC<PembiayaanBayarPage> {
  // ignore: unused_field
  PembiayaanController _con;
  int number = 0;
  _PembiayaanBayarPageState() : super(PembiayaanController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForTagihanPembiayaan(slug: widget.routeArgument.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
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
        title: Text("Tagihan Pembiayaan",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RefreshIndicator(
                onRefresh: _con.refreshList,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.tagihanList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(6)),
                        boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: Offset(2, 2),
                              blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 3, color: bodylight),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Checkbox(
                                      tristate: false,
                                      splashRadius: 30,
                                      value: _con.tagihanSelected.contains(_con.tagihanList.elementAt(index).id),
                                      onChanged: (bool selected) {
                                        _con.ontagihanSelected(selected, _con.tagihanList.elementAt(index).id);
                                      },
                                      activeColor : Theme.of(context).primaryColor,
                                    ),
                                ),
                                // Text("Angsuran Ke " + tagihan.angsuranke.toString(),
                                //   style: TextStyle(fontSize: 12),
                                // ),
                                Text(_con.tagihanList.elementAt(index).nomor,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Angsuran Ke " + _con.tagihanList.elementAt(index).angsuranke.toString(),
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                    Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(_con.tagihanList.elementAt(index).jumlahAngsuran).toString(),
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Jatuh Tempo ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(_con.tagihanList.elementAt(index).tempo,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Bayar'),
                SizedBox(height: 6,),
                Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(_con.totalBayar).toString(), 
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              width: size.width/3,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _con.simpanPengajuan();
                }, 
                child: Text('Bayar', style: TextStyle(
                  color: Colors.white),
                  ),
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}