import 'package:bumaba/Modules/Pembiayaan/pembiayaan_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Config/color.dart';


import '../../route_argument.dart';
import 'pembiayaan_controller.dart';
import '../Main/main_app_bar.dart';

// ignore: must_be_immutable
class PembiayaanTunaiDetailPage extends StatefulWidget {
  RouteArgument routeArgument;

  PembiayaanTunaiDetailPage({Key key, this.routeArgument}) : super(key: key);
  
  @override
  _PembiayaanTunaiDetailPageState createState() {
    return _PembiayaanTunaiDetailPageState();
  }
}

class _PembiayaanTunaiDetailPageState extends StateMVC<PembiayaanTunaiDetailPage> {
  // ignore: unused_field
  PembiayaanController _con;
  Map param = {};
  final NumberFormat _currency = new NumberFormat.currency(locale : 'id', symbol: 'Rp', decimalDigits: 0);
  _PembiayaanTunaiDetailPageState() : super(PembiayaanController()) {
    _con = controller;
  }

  @override
  void initState() {
    param = widget.routeArgument.param;
    print(param["slug"]);
    _con.listenPembiayaanDetail(slug: param["slug"], id: param["id"]);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar('Detail Pembiayaan'),
      body: _con.detail == null
          ? CircularLoadingWidget(height: size.height)
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                color: mainColor,
                padding: EdgeInsets.only(top: 10),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Jumlah Pembiayaan",
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
                        Text(_con.detail?.jumlah == null ? '0' : NumberFormat.currency(locale : 'id', symbol: '', decimalDigits: 0).format(_con.detail.jumlah).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top:10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          statusbadge(_con.detail.status)
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tanggal Pengajuan",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text(_con.detail.tglPengajuan,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No. Pembiayaan",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text(_con.detail.nomor,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Durasi Pembiayaan",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text(_con.detail.durasi.toString() +' Bulan',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Jumlah Pembayaran",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text('Rp 0',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Biaya Admin",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text(_currency.format(_con.detail.biayaAdmin).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bagi Hasil",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          
                          Text(_currency.format(_con.detail.bagiHasil).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                )
              ),

              // if(_con.detail.status == 1)
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom:4),
                child: Text('Rincian Angsuran Bulanan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:FontWeight.w600
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _con.detail.angsuran.length,
                    itemBuilder: (context, index) {
                      return ListAngsuran(_con.detail.angsuran.elementAt(index));
                    },
                  ),
              ),
            ],
        ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ListAngsuran(PembiayaanDetail angsuran){
  return InkWell(
      onTap: (){ },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: bodylight),
          ),
          color: Colors.white,
        ),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(angsuran.angsuranke +", "+ NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(angsuran.jumlahAngsuran).toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 6,),
                Text("Jatuh Tempo : "+ angsuran.tempo,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            
            Text(angsuran.status == 0 ? 'Belum Lunas' : 'Lunas',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
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