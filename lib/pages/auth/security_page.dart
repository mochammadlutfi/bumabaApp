import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../controllers/user_controller.dart';
import '../../repository/user_repository.dart' as userRepo;

import '../../Config/app.dart' as config;
import '../../Core/helper.dart';
import '../../../components/buttons/button_block_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  UserController _con;

  _LoginPageState() : super(UserController()) {
    _con = controller;
  }
  
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
      WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/img/bg/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/img/bg/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(30) - 80,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(37),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/img/logo_hor.png",
                      width: size.width * 0.50,
                    ),
                  ],
                )
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(40) - 20,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                padding: EdgeInsets.only(top: 0, right: 27, left: 27, bottom: 20),
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(40),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (input) => _con.user.nohp = input,
                        validator: validateMobile,
                        decoration: InputDecoration(
                          labelText: 'No HP',
                          // labelStyle: TextStyle(color: Theme.of(context).sec),
                          contentPadding: EdgeInsets.all(12),
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.password = input,
                        validator: (input) => input.length < 3 ? 'Password Kurang Dari 3 Karakter' : null,
                        obscureText: _con.hidePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '????????????????????????????????????',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _con.hidePassword = !_con.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 15),
                      ButtonBlockWidget(
                        text: Text(
                          'Login Sekarang',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          // _con.login();
                          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
                        },
                        border: Colors.transparent
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateMobile(String value) {
    // String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    // RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
          return 'Masukan Nomor HP';
    }
    // else if (!regExp.hasMatch(value)) {
    //       return 'Nomor HP Tidak Valid';
    // }
    return null;
  }    
}
