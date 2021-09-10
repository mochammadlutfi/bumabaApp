import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:bumaba/Modules/PinSecure/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../route_argument.dart';


class PinChangeSetupPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PinChangeSetupPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PinChangeSetupPageState createState() => _PinChangeSetupPageState();
}

class _PinChangeSetupPageState extends StateMVC<PinChangeSetupPage> with SingleTickerProviderStateMixin {
  PinController _con;

  _PinChangeSetupPageState() : super(PinController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar("Ubah Security Code"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
                child: Column(
                  children: <Widget>[
                    Text("Buat Security PIN Baru",
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
                          Navigator.of(context).pushNamed('/PinChangeConfirm', arguments: new RouteArgument(param: value));
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


