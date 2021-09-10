
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Pembayaran/components/pulsa_comp.dart';
import 'package:bumaba/Modules/Pembayaran/pulsa_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';

class PulsaPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  RouteArgument routeArgument;

  PulsaPage({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends StateMVC<PulsaPage> with SingleTickerProviderStateMixin {
  PulsaController _con;

  _PulsaPageState() : super(PulsaController()) {
    _con = controller;                                                                                                                                          
  }
  
  @override
  void initState() {
    _con.type = widget.routeArgument.id;
    _con.listenOperator();
    _con.listenForListPulsa(type: widget.routeArgument.id);
    super.initState();
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
                    padding: EdgeInsets.fromLTRB(16, 10, 22, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomor HP",
                          style: TextStyle(fontSize: 13, color: greytext, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 3),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                          // padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(6),
                            color: bgLight,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  initialValue: _con.nohp,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 14),
                                  onChanged:(value){
                                    if(value.length > 3){
                                      setState(() {
                                        _con.nohp = value;
                                        _con.cekOperator(value);
                                        _con.listenForListPulsa(type: widget.routeArgument.id);
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                )
                              ),
                              Offstage(
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _con.nohp ='';
                                      _con.operator ='';
                                      _con.nohpField.clear();
                                    });
                                  },
                                  child: Container(
                                      width: 10,
                                      height: 10,
                                      child: Icon(Icons.cancel,color: Colors.grey,size: 17,),
                                  ),
                                ),
                              )
                            ],
                          ),
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
}


