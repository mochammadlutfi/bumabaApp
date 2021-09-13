import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/payment_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: unused_import
import '../../../Config/color.dart';


// ignore: must_be_immutable
class PaymentConfirmPage extends StatefulWidget {
  RouteArgument routeArgument;

  PaymentConfirmPage({Key key, this.routeArgument}) : super(key: key);
  @override
  _PaymentConfirmPageState createState() {
    return _PaymentConfirmPageState();
  }
}

class _PaymentConfirmPageState extends StateMVC<PaymentConfirmPage> {
  PaymentController _con;

  _PaymentConfirmPageState() : super(PaymentController()) {
    _con = controller;
  }

  @override
  void initState() {
    if(widget.routeArgument.param["id"] == null){
      _con.payment = widget.routeArgument.param["value"];
    }else{
      _con.listenPaymentDetail(id: widget.routeArgument.param["id"]);
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return new Scaffold(
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
        title: Text("Metode Pembayaran",
            style: AppTheme.getTextStyle(
                themeData.textTheme.headline6,
                fontWeight: 700)),
      ),
      key: _con.scaffoldKey,
      body: _con.payment.bankdetail == null ? CircularLoadingWidget(height: size.height) : SafeArea(
          child: SingleChildScrollView(
          child : Column(
            children: [  
              _con.payment.bankdetail == null ? SizedBox.shrink() :
              Container(
                margin: EdgeInsets.only(top:16),
                width: size.width,
                padding: EdgeInsets.fromLTRB(14, 16, 14, 21),
                decoration : BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LAKUKAN TRANSFER KE REKENING BUMABA",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),

                    SizedBox(height: 8,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2, // 60% of space => (6/(6 + 4))
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            child: Image.network(_con.payment.bankdetail.logo,
                              height: 30,
                            ),
                          )
                        ),
                        SizedBox(width: 10,),
                        
                        Expanded(
                          flex: 5, // 60% of space => (6/(6 + 4))
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Text(
                                "Bank " + _con.payment.bankdetail.nama,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                _con.payment.bankdetail.atasNama,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 0),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: new BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _con.payment.bankdetail.rekening,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 24,
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                  Clipboard.setData(ClipboardData(text: _con.payment.bankdetail.rekening));
                                  Fluttertoast.showToast(msg: 'No Rekening sudah disalin');
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Salin',
                                style: TextStyle(fontSize : 12,color: mainColor)
                              ),
                            ),
                          )
                          
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ), 

              _con.payment.bankdetail == null ? SizedBox.shrink() :
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: size.width,
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: bodylight),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Nominal Transfer",
                          style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 0),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xfff3f3f3),
                        borderRadius: new BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(_con.payment.jumlah + int.parse(_con.payment.kode)).toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          
                          SizedBox(
                            height: 24,
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                  Clipboard.setData(ClipboardData(text: (_con.payment.jumlah + int.parse(_con.payment.kode)).toString()));
                                  Fluttertoast.showToast(msg: 'Nominal Transfer sudah disalin');
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Salin',
                                style: TextStyle(fontSize : 12,color: mainColor)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10, right: 0),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xfffff8e5),
                        borderRadius: new BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Row(
                        children: [
                          
                          Text('Pastikan Nominal Transfer Sesuai!',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                width: size.width,
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                color: Colors.white,
                child: RichText(
                    text: TextSpan(
                      text: 'Transfer sebelum ',
                      style: TextStyle(fontSize: 13, color : Colors.black),
                    children: [
                      TextSpan(
                        text: _con.payment.tgl, 
                        style: TextStyle(color: Colors.black, fontSize: 13, fontWeight : FontWeight.w600)
                      ),
                      TextSpan(
                        text: ' atau transaksi kamu akan dibatalkan otomatis oleh sistem',
                        style: TextStyle(fontSize: 13, color : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: size.width,
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: bodylight),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No Transaksi",
                          style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
                        ),

                        
                        Text(
                          '#' + _con.payment.transaksi.nomor,
                          style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                color: Colors.white,
                child:
                    ExpansionTile(
                      title: Text("Detail",
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
                      ),
                      children: <Widget>[

                      ],
                    ),
              ),

              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  _con.payment.bankdetail == null ? SizedBox.shrink() : Container(
        height: 130,
        color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
              RichText(
                text: TextSpan(
                  text: 'Sudah transfer via ',
                  style: TextStyle(fontSize: 13, color : Colors.black),
                children: [
                  TextSpan(
                    text: "ATM/internet/mobile banking", 
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight : FontWeight.w600)
                  ),
                  TextSpan(
                    text: '? Klik tombol dibawah untuk mengkonfirmasi pembayaran. ',
                    style: TextStyle(fontSize: 13, color : Colors.black),
                  ),
                  
                  TextSpan(
                    text: "Koperasi BUMABA tidak memproses transaksi yang belum di konfirmasi", 
                    style: TextStyle(color: Colors.black, fontSize: 13, fontWeight : FontWeight.w600)
                  ),
                ],
              ),
            ),

            Container(
              width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/TransaksiProcess', arguments: new RouteArgument(param: _con.payment));
                    _con.confirmPayment(_con.payment.id);
                  }, 
                  child: Text('Saya Sudah Transfer', style: TextStyle(
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


