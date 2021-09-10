import 'package:bumaba/Modules/Payment/payment_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

import '../Main/main_app_bar.dart';
import 'components/bank_list.dart';

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
    print(param["tagihan_id"]);
    _con.listenBankList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar('Metode Pembayaran'),
      body: _con.bankList.isEmpty ? CircularLoadingWidget(height: size.height / 2) : 
        RefreshIndicator(
          onRefresh: _con.refreshList,
          child: Column(
            children: [
              
                Container(
                  margin: EdgeInsets.only(top:16),
                  width: size.width,
                  padding: EdgeInsets.fromLTRB(20, 17, 20, 21),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Isi Saldo",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits : 0).format(widget.routeArgument.param["nominal"]).toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ), 

                Container(
                  margin: EdgeInsets.fromLTRB(10, 16, 10, 0),
                  width: size.width,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
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
                    // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.white,
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



