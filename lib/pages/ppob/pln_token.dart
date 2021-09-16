
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/ppob_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';




class PLNTokenPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  PLNTokenPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PLNTokenPageState createState() => _PLNTokenPageState();
}

class _PLNTokenPageState extends StateMVC<PLNTokenPage> {
  PPOBController _con;
  String code = '';
  TextEditingController phoneController = new TextEditingController();
  Map parameter = {};
  final NumberFormat _currency = new NumberFormat.currency(locale : 'id', symbol: 'Rp', decimalDigits: 0);

  
  _PLNTokenPageState() : super(PPOBController()) {
    _con = controller;                                                                                                                                          
  }

  // @override
  void initState() {
    _con.listenPLN();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _con.pagingController.dispose();
  //   super.dispose();
  // }
  
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _con.ppobList.length == 0 ? CircularLoadingWidget(height: size.height/2) :
    SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID PELANGGAN", 
                  style: AppTheme.getTextStyle(Theme.of(context).textTheme.subtitle2,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: 700),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller : phoneController,
                    style: AppTheme.getTextStyle(
                        Theme.of(context).textTheme.bodyText1,
                        letterSpacing: 0.1,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: 500),
                    decoration: InputDecoration(
                      hintText: "Masukan ID Pelanggan",
                      hintStyle: AppTheme.getTextStyle(
                          Theme.of(context).textTheme.bodyText1,
                          letterSpacing: 0.1,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: 500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xfff5f7f9),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 6, 0),
                      suffix: InkWell(
                        onTap: (){
                          _con.listenPLNID(phoneController.text);
                        },
                        child : Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Text('Cek ID',
                              style : TextStyle(color: Colors.white, fontSize: 14)
                            )
                          ),
                        ),
                      )
                    ),
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (value){
                      _con.listenPLNID(phoneController.text);
                    },
                  ),
                ),
                if(_con.pln.name != null && _con.plnError == false)
                Container(
                  margin: EdgeInsets.only(top:15),
                  padding : EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFc3f1d1),
                    borderRadius: new BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_con.pln.segmentPower+' - '+_con.pln.name),
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color : Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),

                if(_con.plnError == true)
                Container(
                  margin: EdgeInsets.only(top:15),
                  padding : EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFFfcc9cb),
                    borderRadius: new BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ID Pelanggan Salah!"),
                      Icon(
                        FlutterIcons.close_circle_mco,
                        color : Color(0xFFdc395f),
                      ),
                    ],
                  ),
                )
                // _con.pln
              ],
            ),
          ),

          if(_con.pln.name != null)
          Expanded(
            child : 
            Container(
              width: size.width,
              margin : EdgeInsets.only(top:15),
              padding : EdgeInsets.fromLTRB(14, 20, 14, 0),
              color : Colors.white,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.ppobList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          _con.payment.slug = "ppob";
                          _con.payment.service = "PLN Token";
                          _con.payment.jumlah = int.parse(_con.ppobList.elementAt(index).nominal) + 2000;
                          _con.payment.ppob = _con.ppobList.elementAt(index);
                          _con.payment.ppob.operator = "pln";
                          _con.payment.ppob.phone = phoneController.text;
                          code = _con.ppobList.elementAt(index).code;
                        });
                      },
                      child : Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: code != _con.ppobList.elementAt(index).code ? Colors.white : Theme.of(context).primaryColor.withOpacity(0.20),
                          border: Border.all(
                            width : 1,
                            color: code != _con.ppobList.elementAt(index).code ? Color(0xFFc8c8c8) : Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children : [
                            Text(_con.ppobList.elementAt(index).nominal,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            Text('Harga',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              )
                            ),
                            Text(NumberFormat.currency(locale : 'id', symbol : 'Rp', decimalDigits: 0).format(_con.ppobList.elementAt(index).harga).toString()),
                          ]
                        ),
                      )
                    );
                  }
                ),
              )
            ),
          ),
          if(_con.pln.name != null)
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: _con.payment.jumlah != null && code != null ? Colors.green : Colors.grey[200],
                          minimumSize: Size(100, 50),
                      ),
                      onPressed:  _con.payment.jumlah != null && code != null ? (){
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.53,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin : EdgeInsets.only(top:15),
                                    padding : EdgeInsets.symmetric(horizontal: 10),
                                    child : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding : EdgeInsets.fromLTRB(10, 0, 10, 10),
                                          child: Text("Informasi Pelanggan",
                                          style: AppTheme.getTextStyle(
                                            Theme.of(context).textTheme.headline6,
                                            letterSpacing: 0.1,
                                            color: Theme.of(context).colorScheme.primary,
                                            fontWeight: 700)
                                          ),
                                        ),
                                        RowText(
                                          label: "ID Pelanggan",
                                          value : _con.pln.subscriberID,
                                        ),
                                        RowText(
                                          label: "Nama",
                                          value : _con.pln.name,
                                        ),
                                        RowText(
                                          label: "No Meter",
                                          value : _con.pln.noMeter,
                                        ),
                                        RowText(
                                          label: "Daya",
                                          value : _con.pln.segmentPower,
                                        ),
                                        
                                      ],
                                    )
                                  ),

                                  Container(
                                    margin : EdgeInsets.only(top:15),
                                    padding : EdgeInsets.symmetric(horizontal: 10),
                                    child : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding : EdgeInsets.fromLTRB(10, 0, 10, 10),
                                          child: Text("Detail Pembayaran",
                                          style: AppTheme.getTextStyle(
                                            Theme.of(context).textTheme.headline6,
                                            letterSpacing: 0.1,
                                            color: Theme.of(context).colorScheme.primary,
                                            fontWeight: 700)
                                          ),
                                        ),
                                        RowText(
                                          label: "Nominal Token",
                                          value : _currency.format(int.parse(_con.payment.ppob.nominal)).toString(),
                                        ),
                                        
                                        RowText(
                                          label: "Biaya Admin",
                                          value : _currency.format(2000).toString(),
                                        ),
                                        
                                        Container(
                                          margin: EdgeInsets.only(top:10),
                                          padding : EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFc3f1d1),
                                            borderRadius: new BorderRadius.all(Radius.circular(6)),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Harga"),
                                              Text(_currency.format(int.parse(_con.payment.ppob.nominal)+ 2000).toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                
                                  Container(
                                    margin : EdgeInsets.only(top:15),
                                    padding : EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(60)),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pushNamed('/PPOBReview', arguments: RouteArgument(param: _con.payment));
                                      },
                                      style: ButtonStyle(
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4.0)),
                                          ),
                                          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                                      ),
                                      child: Text(
                                        'Lanjut',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      } : null,
                      child: Text(
                          'Lanjutkan',
                      style: TextStyle(
                        color:  _con.payment.jumlah != null && code != null ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowText extends StatelessWidget {
  final String label;
  final String value;
  const RowText({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : EdgeInsets.fromLTRB(10, 0, 10, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
            style: AppTheme.getTextStyle(
            Theme.of(context).textTheme.caption,
            letterSpacing: 0.1,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: 500),
          ),
          
          Text(value,
            style: AppTheme.getTextStyle(
            Theme.of(context).textTheme.caption,
            letterSpacing: 0.1,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: 500),
          ),
        ],
      ),
    );
  }
}



