
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Main/main_app_bar.dart';
// ignore: unused_import
import 'package:bumaba/Modules/Pembayaran/pulsa_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';
import 'pembiayaan_controller.dart';
import 'pembiayaan_model.dart';


// ignore: must_be_immutable
class PembiayaanDetailPage extends StatefulWidget {
  RouteArgument routeArgument;
  PembiayaanDetailPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PembiayaanDetailPageState createState() => _PembiayaanDetailPageState();
}

class _PembiayaanDetailPageState extends StateMVC<PembiayaanDetailPage> with SingleTickerProviderStateMixin {
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
      : Container(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: size.height / 5,
                primary: false,
                floating: false,
                pinned: false,
                automaticallyImplyLeading: false,
                title: Container(
                  color: mainColor,
                  height: size.height / 7,
                  // padding: EdgeInsets.only(top: 10),
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
                        width: 80,
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
              ),
            ];
          },
          body: Scaffold(
            body: Column(
              children: [
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
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child:  Text("Pembayaran Bulan Ini",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                        ),
                        Divider(
                          thickness : 1,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_con.listDetail?.jumlahTagihan == 0 ? 'Tidak ada tagihan bulan sekarang' : NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits:0).format(_con.listDetail.jumlahTagihan).toString(),
                                style: TextStyle(
                                  fontSize: _con.listDetail?.jumlahTagihan != 0 ? 16 : 13,
                                  fontWeight : _con.listDetail?.jumlahTagihan != 0 ? FontWeight.bold : FontWeight.w400,
                                ),
                              ),

                              if(_con.listDetail?.jumlahTagihan != 0)
                              Container(
                                height: 26,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/PembiayaanBayar', arguments: new RouteArgument(id: widget.routeArgument.id));
                                  }, 
                                  child: Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                  style: ElevatedButton.styleFrom(
                                    primary: mainColor,
                                  ),
                                ),
                              ),

                            ],
                            
                          ),
                        ),
                        
                      ],
                    ),
                ),

                if(_con.listDetail.pengajuan.length != 0)
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 4),
                  width: double.infinity,
                  child: Text("Pengajuan Pembiayaan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),                
                Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _con.listDetail.pengajuan.length,
                      itemBuilder: (context, index) {
                        return RiwayatItem(pembiayaan: _con.listDetail.pengajuan.elementAt(index), slug : _con.listDetail.slug);
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
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child:  Text("Jadwal Pembayaran",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _con.listDetail.angsuran.length,
                          itemBuilder: (context, index) {
                            return jadwalPembayaran(_con.listDetail.angsuran.elementAt(index));
                          },
                        ),                        
                      ],
                    ),
                ),


              ],
            ),
          )
  
        ),
      ),
    );
  }
}


class RiwayatItem extends StatelessWidget {
  final Pembiayaan pembiayaan;
  final String slug;
  const RiwayatItem({
    Key key,
    this.pembiayaan,
    this.slug,
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
            border: Border(
              bottom: BorderSide(width: 1.0, color: bodylight),
            ),
            color: Colors.white,
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 0.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: (){
                Navigator.of(context).pushNamed('/PembiayaanTunaiDetail', arguments: new RouteArgument(id: pembiayaan.id, param: { 'slug' : slug, 'id' : pembiayaan.id}));
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
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 3),
                        Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(pembiayaan.jumlah),
                          style: TextStyle(fontSize: 14, fontWeight : FontWeight.w800),
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
                        statusbadge(pembiayaan.status)
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


Widget jadwalPembayaran(PembiayaanDetail tagihan){
  return InkWell(
      onTap: (){ },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: 
              Text(tagihan.tempo,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ),
            Text( NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits :0).format(tagihan.jumlahAngsuran).toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 10,),
            Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
}

Widget statusbadge(int status){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal : 6),
    decoration: BoxDecoration(
      color: status == 0 ? Colors.orange[100] : bgLight ,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4)
      ),
    ),
    child: Text(status == 0 ? "Verifikasi" : "Aktif",
      style: TextStyle(
        fontSize: 12, 
        fontWeight : FontWeight.w500, 
        color: status == 0 ? orangetext : mainColor
      ),
    ),
  );
}

