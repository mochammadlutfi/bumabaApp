
import 'package:bumaba/config/app_theme.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

import '../../../Config/color.dart';


import '../../route_argument.dart';
import '../../controllers/pembiayaan_controller.dart';

// ignore: must_be_immutable
class PembiayaanTunaiPage extends StatefulWidget {
  RouteArgument routeArgument;

  PembiayaanTunaiPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _PembiayaanTunaiPageState createState() {
    return _PembiayaanTunaiPageState();
  }
}

class _PembiayaanTunaiPageState extends StateMVC<PembiayaanTunaiPage> {
  PembiayaanController _con;
  List<String> tenorLabel =["2 Bulan","3 Bulan","6 Bulan","12 Bulan"];
  List<int> tenorVal =[2,3,6,12];
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(locale: 'id',decimalDigits: 0,symbol: 'Rp',);
  int jumlah = 0;
  int limit = 0;
  _PembiayaanTunaiPageState() : super(PembiayaanController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.hitungPengajuanTunai();
    _con.pengajuan.slug = widget.routeArgument.id;
  }
  
  @override
  Widget build(BuildContext context) {
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
        title: Text("Pengajuan Pembiayaan",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)),
      ),
      body: SafeArea(
        child : Column(
            children: [
              Form(
                key: _con.formPembiayaanTunai,
                autovalidateMode: AutovalidateMode.always,
                child: Container(
                  width: size.width,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Masukan jumlah pembiayaan",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text('Minimal pembiayaan mulai dari Rp200.000 - Rp' + widget.routeArgument.param,
                        style: TextStyle(
                          color: greytext,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        // controller: _jumlahController,
                        validator: (value) {
                          // int jumlah = ;
                          if(value.isNotEmpty){
                            int jumlah = int.parse(value.replaceAll(new RegExp(r'\D'),''));
                            String limit = widget.routeArgument.param;
                            if (jumlah < 200000) {
                                return 'Jumlah Pembiayaan Minimal Rp200.000';
                            }else if(jumlah > int.parse(limit.replaceAll(new RegExp(r'\D'),''))){
                                return 'Jumlah Pembiayaan Minimal Rp' + widget.routeArgument.param;
                            }
                          }else{
                            return 'Jumlah Pembiayaan Wajib Diisi!';
                          }
                          return null;
                        },
                        initialValue: _formatter.format('200000'),
                        inputFormatters: [_formatter],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rp200.000',
                          contentPadding: EdgeInsets.all(12),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                        onChanged:(value){
                          jumlah = value.isNotEmpty ? int.parse(value.replaceAll(new RegExp(r'\D'),'')) : 0;
                          limit = int.parse(widget.routeArgument.param.replaceAll(new RegExp(r'\D'),''));
                          if (jumlah > 200000) {
                              if(jumlah > limit){
                                jumlah = limit;
                              }else{
                                jumlah = jumlah;
                              }
                            }else{
                              jumlah = 200000;
                            }
                          setState(() {
                              _con.pengajuan.jumlah = jumlah;
                            _con.hitungPengajuanTunai();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Durasi Pembiayaan
              Container(
                margin: EdgeInsets.only(top:10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pilih Durasi Pembiayaan",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: CustomRadioButton(
                        elevation : 10,
                        buttonWidth : MediaQuery.of(context).size.width * 0.42,
                        buttonLables: tenorLabel,
                        buttonValues: tenorVal,
                        radioButtonValue: (value,index){
                          setState(() { 
                            _con.pengajuan.durasi = value;
                            _con.hitungPengajuanTunai();
                          });
                        },
                        horizontal: true,
                        buttonSpace: 10,
                        lineSpace: 10,
                        buttonBorderColor : mainColor,
                        buttonColor: Colors.white,
                        selectedColor: mainColor,
                        unselectedButtonBorderColor : mainColor,
                      ),
                    ),
                  ],
                )
              ),
              
              Container(
                margin: EdgeInsets.only(top:10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jumlah yang Di Ajukan",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.pengajuan.jumlah),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Biaya Admin (1.00%)",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.admin),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jumlah yang Diterima",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.diterima),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),


                    
                  ],
                )
              ),

              
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jumlah Angsuran",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.jumlahAngsuran),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Angsuran Pokok",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.angsuranPokok),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Angsuran Bagi Hasil Bulanan (3.95% / bulan)",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        
                        Text(NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(_con.bagiHasil),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
              
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
            child: ElevatedButton(
              onPressed: () {
                _con.simpanPengajuan();
              }, 
              child: Text('Ajukan', style: TextStyle(
                color: Colors.white),
                ),
              style: ElevatedButton.styleFrom(
                primary: mainColor,
              ),
            ),
        ),
      ),
    );
  }
}

String validatePembiayaan(String value) {
    int jumlah = int.parse(value.replaceAll(new RegExp(r'\D'),''));
    if (jumlah > 200000) {
        return 'Jumlah Pembiayaan Minimal Rp200.000';
    }
    // else if(jumlah > _con.detail.pembiayaan)
    return null;
  }
