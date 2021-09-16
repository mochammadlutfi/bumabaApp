import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/components/payment/bank_list.dart';
import 'package:bumaba/controllers/payment_controller.dart';
import 'package:bumaba/models/user_model.dart';
import 'package:bumaba/repository/simla_repository.dart';
import 'package:bumaba/components/pin/pin_bottom_sheet.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

import '../../components/payment/payment_method_simla.dart';

class PPOBReviewPage extends StatefulWidget {
  final RouteArgument routeArgument;

  PPOBReviewPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PPOBReviewPageState createState() {
    return _PPOBReviewPageState();
  }
}

class _PPOBReviewPageState extends StateMVC<PPOBReviewPage> {
  PaymentController _con;
  Map param = new Map();
  Map result = new Map();

  _PPOBReviewPageState() : super(PaymentController()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() {
     _con.payment = widget.routeArgument.param;
    });
    _con.listenBankList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
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
        title: Text("Metode Pembayaran",
            style: AppTheme.getTextStyle(
                themeData.textTheme.headline6,
                fontWeight: 700)),
      ),
      backgroundColor: bodylight,
      body: _con.bankList.isEmpty ? CircularLoadingWidget(height: size.height / 2) : RefreshIndicator(
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          color : Colors.white,
                          borderRadius: new BorderRadius.only(
                            bottomLeft: new Radius.circular(4),
                            bottomRight: new Radius.circular(4)
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                
                PaymentMethodSimlaWidget(
                  ontap : (){
                    if(currentSaldo.value > _con.payment.jumlah){
                      setState(() {
                          _con.payment.method = "simla";
                          _con.payment.user = new User();
                      });
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SecurityPinBottomSheet(
                            scaffoldKey: _con.scaffoldKey,
                            onComplete : (value){
                              setState(() { 
                                _con.payment.user.securityCode = value;
                              });
                              _con.payRequest();
                            }
                          );
                        },
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    }
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
                            "BAYAR VIA BANK TRANSFER",
                            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
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
                              _con.payment.bankId = _con.bankList.elementAt(index).id;
                            });
                              // _con.payRequest();
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



