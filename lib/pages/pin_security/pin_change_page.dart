import 'package:bumaba/Config/color.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:pin_code_fields/pin_code_fields.dart';


class PinChangePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PinChangePage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PinChangePageState createState() => _PinChangePageState();
}

class _PinChangePageState extends StateMVC<PinChangePage> with SingleTickerProviderStateMixin {
  PinController _con;

  _PinChangePageState() : super(PinController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        centerTitle: true,
        title: Text("Ubah Security PIN",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 800)
        ),
      ),
      key: _con.scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
                child: Column(
                  children: <Widget>[
                    Text("Masukan Security PIN Kamu Saat Ini ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Security PIN digunakan untuk masuk ke akun kamu dan bertransaksi", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: greytext
                      ),
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 0, right: 27, left: 27, bottom: 20),
                child: Form(
                  // key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      PinCodeTextField(
                        appContext: context,
                        autoFocus: true,
                        enablePinAutofill : false,
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveColor : mainColor,
                          selectedColor : mainColor,
                          activeFillColor : bgLight,
                          disabledColor : bgLight,
                          inactiveFillColor : bgLight,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                        ),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (value) {
                          _con.accessApp(value, "change");
                        },
                        onChanged: (String value) { 

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


