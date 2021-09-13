import 'package:bumaba/components/pin/pin_bottom_sheet.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/simla_controller.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: unused_import
import '../../../Config/color.dart';


// ignore: must_be_immutable
class SimlaTransferConfirmPage extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SimlaTransferConfirmPage({Key key, this.routeArgument, this.parentScaffoldKey}) : super(key: key);

  _SimlaTransferConfirmPageState createState() => _SimlaTransferConfirmPageState();
}

class _SimlaTransferConfirmPageState extends StateMVC<SimlaTransferConfirmPage> {
  SimlaController _con;
  final NumberFormat _currency = new NumberFormat.currency(locale : 'id', symbol: 'Rp', decimalDigits: 0);

  _SimlaTransferConfirmPageState() : super(SimlaController()) {
    _con = controller;
  }

  @override
  void initState() {
    setState(() { 
      _con.simla = widget.routeArgument.param;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
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
        title: Text("Review Transfer",
            style: AppTheme.getTextStyle(
                themeData.textTheme.headline6,
                fontWeight: 700)
        ),
      ),
      key: widget.parentScaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: bgLight)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  SizedBox(height: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Jumlah Transfer",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(_currency.format(_con.simla.jumlah).toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  SizedBox(height: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Keterangan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(_con.simla.keterangan == null ? '' : _con.simla.keterangan,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SecurityPinBottomSheet(
                                scaffoldKey: widget.parentScaffoldKey,
                                onComplete : (value){
                                  // print(value);
                                  setState(() { 
                                    _con.simla.user.securityCode = value;
                                  });
                                  _con.confirmTransfer();
                                }
                              );
                            },
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                            ),
                            backgroundColor: MaterialStateProperty.all(mainColor)
                        ),
                        child: Text(
                          'Transfer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ),
          ],
        )
        
      )
    );
  }
}

