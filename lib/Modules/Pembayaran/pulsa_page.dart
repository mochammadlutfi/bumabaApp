
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Pembayaran/components/pulsa_comp.dart';
import 'package:bumaba/Modules/Pembayaran/pulsa_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';

// ignore: must_be_immutable
class PulsaPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  RouteArgument routeArgument;

  PulsaPage({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends StateMVC<PulsaPage> with SingleTickerProviderStateMixin {
  PulsaController _con;
  TextEditingController phoneController = new TextEditingController();

  _PulsaPageState() : super(PulsaController()) {
    _con = controller;                                                                                                                                          
  }
  
  @override
  void initState() {
    _con.type = widget.routeArgument.id;
    _con.listenOperator();
    _con.listenForListPulsa(type: widget.routeArgument.id);
    super.initState();
    phoneController.text = _con.nohp;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: bgLight,
        leading: BackButton(
          color: mainColor
        ), 
        titleSpacing: 0,
        title: Text(_con.type.toUpperCase(), style: TextStyle(color: mainColor)),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.center,
            color: bgLight,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_con.operator,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ),
          preferredSize: Size(40, 40),
        ),
      ),
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: size.height * 0.14,
                primary: false,
                backgroundColor: Colors.white,
                floating: false,
                pinned: false,
                automaticallyImplyLeading: false,
                title: new Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomor Ponsel",
                          style: TextStyle(fontSize: 13, color: greytext, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: phoneController,
                                  style: TextStyle(
                                    fontSize: 14.0, 
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: bodylight,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: blacktext,
                                      ),
                                      onPressed: () {
                                        phoneController.clear();
                                      }
                                    ),
                                  ),
                                  onChanged:(value){
                                    if(value.length > 3){
                                      setState(() {
                                        _con.nohp = value;
                                        _con.cekOperator(value);
                                        _con.listenForListPulsa(type: widget.routeArgument.id);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){

                                }, 
                                icon: Icon(
                                  Icons.contacts_rounded,
                                )
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ),
            ];
          },
          body: Scaffold(
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: _con.pulsaDataList.length,
                    itemBuilder: (context, index) {
                      return PulsaDataItem(
                        data: _con.pulsaDataList.elementAt(index),
                        ontap: (){
                          // _con.pulsaDataList.elementAt(index).nominal
                          paymentMethod(_con.pulsaDataList.elementAt(index).harga, _con.pulsaDataList.elementAt(index).code,_con.pulsaDataList.elementAt(index).nama);
                        },
                      );
                    },
                  ),
                )
              ),
            )
        ),
      ),
    );
  }

  void paymentMethod(harga, code, service){
    Map parameter = {
      'nominal' : harga,
      'slug' : 'ppob',
      'service' : service,
      'phone' : phoneController.text,
      'code' : code,
    };
    if(widget.routeArgument.id == 'pulsa'){
      parameter["title"] = "PEMBELIAN PULSA";
    }else if(widget.routeArgument.id == 'data'){
      parameter["title"] = "PEMBELIAN DATA";
    }
    Navigator.of(context).pushNamed('/PaymentMethod', arguments: RouteArgument(param: parameter));
  }
}


