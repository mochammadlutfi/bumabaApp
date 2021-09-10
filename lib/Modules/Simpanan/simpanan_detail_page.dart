import 'package:bumaba/Modules/Simpanan/components/tagihan_comp.dart';
import 'package:bumaba/Modules/Transaksi/components/transaksi_list_item.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: unused_import
import '../../../Config/color.dart';


import 'simpanan_controller.dart';
import '../Main/main_app_bar.dart';

// ignore: must_be_immutable
class SimpananDetailPage extends StatefulWidget {
  RouteArgument routeArgument;

  SimpananDetailPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _SimpananDetailPageState createState() {
    return _SimpananDetailPageState();
  }
}

class _SimpananDetailPageState extends StateMVC<SimpananDetailPage> {
  SimpananController _con;

  _SimpananDetailPageState() : super(SimpananController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenDetailSimpanan(slug: widget.routeArgument.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: _con.detailSimpanan?.slug == null ? null : mainappbar(_con.detailSimpanan.program),
      body: _con.detailSimpanan == null ? CircularLoadingWidget(height: size.height /2 ): 
        Column(
          children: [
            Container(
              width: size.width,
              color: mainColor,
              padding: EdgeInsets.only(top: 15),
              height: size.height * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Saldo Simpanan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10,),
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
                      Text(_con.detailSimpanan?.saldo == null ? '0' : _con.detailSimpanan.saldo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (_con.detailSimpanan.slug != 'wajib') ? SizedBox.shrink():
            TagihanComp(
              tagihan: _con.detailSimpanan.tagihan,
              ontap: (){
                Navigator.of(context).pushNamed('/TagihanSimpananDetail', arguments: new RouteArgument(id: _con.detailSimpanan.slug));
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[1]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text("Transaksi Terakhir",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/SimpananRiwayat', arguments: new RouteArgument(id : _con.detailSimpanan.slug));
                    },
                    child: Text("Lihat Semua Transaksi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: mainColor
                      ),
                    ),
                  )
                ],
              )
            ),


            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.detailSimpanan.transaksi.length,
                  itemBuilder: (context, index) {
                    return TransaksiListItem(transaksi: _con.detailSimpanan.transaksi.elementAt(index), slug: _con.detailSimpanan.slug);
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}