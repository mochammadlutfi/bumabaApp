
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';
import '../Main/main_app_bar.dart';
import 'simla_controller.dart';

class RiwayatSimlaPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  RiwayatSimlaPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _RiwayatSimlaPageState createState() => _RiwayatSimlaPageState();
}

class _RiwayatSimlaPageState extends StateMVC<RiwayatSimlaPage> {
  SimlaController _con;

  _RiwayatSimlaPageState() : super(SimlaController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    _con.listenRiwayatTransaksi();
    print('sadas');
    super.initState();
  }
  onGoBack(dynamic value) {
    _con.refreshList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar('Riwayat Transaksi'),
      body: _con.riwayat.length == 0 ? CircularLoadingWidget(height: 500) : 
          SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16, 10, 22, 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Riwayat Transaksi",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: RefreshIndicator(
                    color: mainColor,
                    onRefresh: _con.listenRiwayatTransaksi,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _con.riwayat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RiwayatItem(
                          transaksi: _con.riwayat.elementAt(index), 
                          slug : 'sukarela',
                          onTap : (){
                            _con.riwayat.elementAt(index).payment.status == 'Menunggu Pembayaran' ?
                            Navigator.of(context).pushNamed('/PaymentConfirm', arguments: new RouteArgument(param : {"id" : _con.riwayat.elementAt(index).id, "value" : "null"})).then(onGoBack) :
                            Navigator.of(context).pushNamed('/TransaksiDetail', arguments: new RouteArgument(id: _con.riwayat.elementAt(index).id, param : 'sukarela')).then(onGoBack);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}

class RiwayatItem extends StatelessWidget {
  final Transaksi transaksi;
  final String slug;
  final VoidCallback onTap;
  
  const RiwayatItem({
    Key key,
    this.transaksi,
    this.slug,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaksi.jenis,
                    style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                  ),
                  SizedBox(height: 6),
                  Text(transaksi.tgl,
                    style: TextStyle(fontSize: 13, fontWeight : FontWeight.w400, color: blacktext),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(NumberFormat.currency(locale : 'id', symbol : 'Rp', decimalDigits: 0).format(transaksi.jumlah).toString(),
                    style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                  ),
                  SizedBox(height: 6),
                  Text(transaksi.payment.status,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight : FontWeight.w600, 
                      color: getStatusColor(transaksi.payment.status)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getStatusColor(String status){
  if(status == 'Verifikasi' || status == 'Menunggu Pembayaran'){
    return orangetext;
  }else if(status == 'Berhasil'){
    return mainColor;
  }
}
