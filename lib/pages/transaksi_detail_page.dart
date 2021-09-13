
import 'package:bumaba/controllers/transaksi_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Config/color.dart';
import '../route_argument.dart';

// ignore: must_be_immutable
class TransaksiDetailPage extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TransaksiDetailPage({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _TransaksiDetailPageState createState() => _TransaksiDetailPageState();
}

class _TransaksiDetailPageState extends StateMVC<TransaksiDetailPage> {
  TransaksiController _con;

  _TransaksiDetailPageState() : super(TransaksiController()) {
    _con = controller;                                                                                                                                          
  }
  @override
  void initState() {
    _con.listenDetailTransaksi(id: widget.routeArgument.id, slug : widget.routeArgument.param);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeData.colorScheme.primary,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          // title: Text("Detail Transaksi",
          //     style: AppTheme.getTextStyle(
          //         themeData.textTheme.headline6,
          //         fontWeight: 700,
          //         color: Colors.white,
          //       )
          // ),
        ),
        key: _con.scaffoldKey,
        body: _con.detailTransaksi == null ? CircularLoadingWidget(height: size.height/2): 
        RefreshIndicator(
          onRefresh: _con.refreshDetail,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: 0,
                child: Container(
                  width: size.width,
                  height: size.height * 0.21,
                  decoration: BoxDecoration(
                    color: mainColor,
                    ),
                ),
              ),
              Positioned(
                top: size.height * 0.06,
                child: Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 2,
                          offset: Offset(0.4, 0.3)
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          )
                        ),
                        child: Stack(
                          clipBehavior : Clip.none,
                          children: [
                            Positioned(
                              child: Container(
                                width: 400,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30,),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(_con.detailTransaksi.hasPaid == 0 ? "Transaksi Kamu Sedang Di Proses" : "Transaksi Berhasil",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tanggal",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(
                                            _con.detailTransaksi.tgl,
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "No Transaksi",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(_con.detailTransaksi.nomor,
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Jenis Transaksi",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(_con.detailTransaksi.jenis,
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Metode Pembayaran",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          _con.detailTransaksi.payment.bankdetail != null ?
                                          Image.network(
                                                _con.detailTransaksi.payment.bankdetail.logo,
                                                height: 20,
                                            )
                                          :
                                          Text(
                                            _con.detailTransaksi.payment.method,
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 3,
                                      thickness: 2,
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(bottom: 6, top: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nominal",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(
                                            NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits : 0).format(_con.detailTransaksi.jumlah),
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    _con.detailTransaksi.payment.method == 'Transfer' ?
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kode Unik",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(
                                            _con.detailTransaksi.payment.kode.toString(),
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ) : SizedBox.shrink(),
                                    

                                    _con.detailTransaksi.payment.method == 'Transfer' ?
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Biaya Admin",
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.normal),
                                          ),
                                          
                                          Text(
                                            NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits : 0).format(_con.detailTransaksi.payment.adminFee).toString(),
                                            style: TextStyle(fontSize: 13, fontWeight : FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ): SizedBox.shrink(),

                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              top: -35,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 4),
                                    color: mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  // ignore: unrelated_type_equality_checks
                                  child: SvgPicture.asset(_con.detailTransaksi.hasPaid == 0 ? "assets/icons/clock_sand.svg" : "assets/icons/check.svg",
                                    color: Colors.white,
                                  ),
                                ),            
                              ),
                            ),
                          ]
                        ),
                      ),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/img/paper_white.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    
  }
}