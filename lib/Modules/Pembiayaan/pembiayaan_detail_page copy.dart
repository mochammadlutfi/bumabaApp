
import 'package:bumaba/Modules/Pembiayaan/pembiayaan_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: unused_import
import '../../../Config/color.dart';


import 'pembiayaan_controller.dart';
import '../Main/main_app_bar.dart';

// ignore: must_be_immutable
class PembiayaanDetailPage extends StatefulWidget {
  RouteArgument routeArgument;


  PembiayaanDetailPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PembiayaanDetailPageState createState() {
    return _PembiayaanDetailPageState();
  }
}

class _PembiayaanDetailPageState extends StateMVC<PembiayaanDetailPage> {
  PembiayaanController _con;

  _PembiayaanDetailPageState() : super(PembiayaanController()) {
    _con = controller;
  } 

  @override
  void initState() {
    _con.listenPembiayaanListDetail(slug: widget.routeArgument.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: _con.listDetail?.slug == null ? null : mainappbar(_con.listDetail.program),
      body: _con.listDetail == null
          ? CircularLoadingWidget(height: 500)
          : Column(
          children: [
            Container(
              width: size.width,
              color: mainColor,
              // padding: EdgeInsets.only(top: 10),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Limit Pembiayaan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Rp",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                          )
                      ),
                      SizedBox(width: 5),
                      Text(_con.listDetail?.limit == null ? '0' : _con.listDetail.limit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),

                  
                  SizedBox(height: 6,),
                  Container(
                    height: 26,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/PembiayaanTunai', arguments: new RouteArgument(id: _con.listDetail.slug, param:  _con.listDetail.limit));
                      }, 
                      child: Text('Ajukan', style: TextStyle(color: mainColor, fontSize: 12, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        primary: bgLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // if(_con.listDetail.pengajuan.length != 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              child: Text("Pengajuan Pembiayaan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),       
            
            Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.listDetail.pengajuan.length,
                  itemBuilder: (context, index) {
                    return RiwayatItem(pembiayaan: _con.listDetail.pengajuan.elementAt(index));
                  },
                ),
            ),


            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child:  Text("Pembayaran Bulan Ini",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                    ),
                    Divider(
                      thickness : 3,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rp 30000000",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                        
                      ),
                    ),
                    
                  ],
                ),
              ),
          ],
        ),
    );
  }
}


class RiwayatItem extends StatelessWidget {
  final Pembiayaan pembiayaan;

  const RiwayatItem({
    Key key,
    this.pembiayaan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 0.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: (){
                Navigator.of(context).pushNamed('/PembiayaanTunaiDetail', arguments: new RouteArgument(id: pembiayaan.id));
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pembiayaan.nomor.toString(),
                          style: TextStyle(fontSize: 14, fontWeight : FontWeight.w500, color: blacktext),
                        ),
                        SizedBox(height: 3),
                        Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(pembiayaan.jumlah),
                          style: TextStyle(fontSize: 16, fontWeight : FontWeight.w700, color: blacktext),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        SizedBox(height: 7),
                        Text("Verifikasi",
                          style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500, color: orangetext),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

