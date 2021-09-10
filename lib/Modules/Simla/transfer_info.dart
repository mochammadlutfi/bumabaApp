import 'package:bumaba/Modules/Simla/simla_controller.dart';
import 'package:bumaba/Modules/Simla/simla_repository.dart';
import 'package:bumaba/route_argument.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// ignore: unused_import
import '../../../Config/color.dart';

import '../Main/main_app_bar.dart';

// ignore: must_be_immutable
class SimlaTransferInfoPage extends StatefulWidget {
  RouteArgument routeArgument;

  SimlaTransferInfoPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _SimlaTransferInfoPageState createState() {
    return _SimlaTransferInfoPageState();
  }
}

class _SimlaTransferInfoPageState extends StateMVC<SimlaTransferInfoPage> {
  // ignore: unused_field
  SimlaController _con;
  CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(locale: 'id',decimalDigits: 0,symbol: 'Rp',);
  int nominal = 0;

  _SimlaTransferInfoPageState() : super(SimlaController()) {
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
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: mainappbar('Transfer'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top:16),
              width: size.width,
              padding: EdgeInsets.fromLTRB(20, 17, 20, 21),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainColor
                          ),
                          child: CircleAvatar(
                            child: Icon(Icons.person, color: Colors.white, size: 30),
                            backgroundColor: Colors.transparent
                          )
                      ),
                    )
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_con.simla.user.nama),
                        Text(_con.simla.user.anggotaID),
                        Text('+62'+_con.simla.user.nohp)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(top:16),
              width: size.width,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 21),
              color: Colors.white,
              child: Form(
                key: _con.formTransfer,
                autovalidateMode: AutovalidateMode.always,
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextFormField(
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Jumlah Wajib Diisi!';
                            }else{
                            int jumlah = int.parse(value.replaceAll(new RegExp(r'\D'),''));
                              if (jumlah > currentSaldo.value) {
                                return 'Saldomu Kurang!';
                              }
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: orangetext                  
                          ),
                          autofocus: true,
                          onSaved: (value) => _con.simla.jumlah = int.parse(value.replaceAll(new RegExp(r'\D'),'')),
                          keyboardType: TextInputType.number,
                          inputFormatters: [_formatter],
                          decoration: InputDecoration(
                            hintText: 'Rp0',
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            border: InputBorder.none,
                          ),
                          // onSaved:(value){
                          //   setState(() { 
                          //     _con.simla.jumlah= int.parse(value.replaceAll(new RegExp(r'\D'),''));
                          //   });
                          // },
                        ),
                          
                        Text(
                          "Saldo saat ini ("+ _formatter.format(currentSaldo.value.toString())+")",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Keterangan (Optional)",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 6,),
                        TextFormField(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black                  
                              ),
                              onSaved: (value) => _con.simla.keterangan = value,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Keterangan',
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: TextButton(
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                          if (_con.formTransfer.currentState.validate()) {
                            _con.formTransfer.currentState.save();
                            Navigator.of(context).pushReplacementNamed('/SimlaTransferConfirm', arguments: RouteArgument(param: _con.simla));
                          }
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
              ),
            ),
          ],
        ),
      )
    );
  }
}

