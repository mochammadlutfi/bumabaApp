import 'package:bumaba/Modules/Payment/payment_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

import '../Main/main_app_bar.dart';
import 'components/bank_list.dart';
import 'components/payment_method_simla.dart';

// ignore: must_be_immutable
class PaymentMethodPage extends StatefulWidget {
  RouteArgument routeArgument;

  PaymentMethodPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PaymentMethodPageState createState() {
    return _PaymentMethodPageState();
  }
}

class _PaymentMethodPageState extends StateMVC<PaymentMethodPage> {
  PaymentController _con;
  Map param = new Map();
  Map result = new Map();

  _PaymentMethodPageState() : super(PaymentController()) {
    _con = controller;
  }

  @override
  void initState() {
    param = widget.routeArgument.param;
    _con.listenBankList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar('Metode Pembayaran'),
      backgroundColor: bodylight,
      body: _con.bankList.isEmpty ? CircularLoadingWidget(height: size.height / 2) : 
        RefreshIndicator(
          onRefresh: _con.refreshList,
          child: Column(
            children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical:10, horizontal: 8),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        margin: EdgeInsets.only(bottom: 1),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          color : Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(6),
                            topRight: new Radius.circular(6)
                          )
                        ),
                        child: Text(
                          param["title"],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
              
                      Container(
                        width: size.width,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          color : Colors.white,
                          borderRadius: new BorderRadius.only(
                            bottomLeft: new Radius.circular(4),
                            bottomRight: new Radius.circular(4)
                          )
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits : 0).format(widget.routeArgument.param["nominal"]).toString(),
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  param["slug"] != 'ppob' ? SizedBox.shrink() :
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      param["phone"],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      param["service"],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        )
                      ),
                    ],
                  ),
                ),

                if(param["service"] != 'sukarela')
                PaymentMethodSimlaWidget(
                  ontap : (){

                  }
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: size.width,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Pilih Metode Pembayaran",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _con.bankList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BankListComponent(
                          bank: _con.bankList.elementAt(index),
                          ontap: (){
                            setState(() {
                              _con.payment.jumlah = param["nominal"];
                              _con.payment.slug = param["slug"];
                              _con.payment.service = param["service"];
                              _con.payment.bankId = _con.bankList.elementAt(index).id;
                              param["tagihan_id"] == null ?  _con.payment.tagihanId = [] :
                              _con.payment.tagihanId = param["tagihan_id"];
                              _con.payRequest();
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        )  
    );
  }
}



