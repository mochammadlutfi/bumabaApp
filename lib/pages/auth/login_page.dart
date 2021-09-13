import 'package:bumaba/config/app_size.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../controllers/user_controller.dart';
import '../../repository/user_repository.dart' as userRepo;

import '../../Config/app.dart' as config;
import '../../Core/helper.dart';

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
      Navigator.of(context).pushReplacementNamed('/SetupPin');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height : 46,
                          child: TextFormField(
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                letterSpacing: 0.1,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 500),
                            decoration: InputDecoration(
                              hintText: "89123456",
                              hintStyle: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText1,
                                  letterSpacing: 0.1,
                                  color: themeData.colorScheme.onBackground,
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
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 11, right: 5, left: 12, bottom: 0), child: Text('+62 ', style: themeData.textTheme.bodyText1)),
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.sentences,
                            onSaved: (input) => _con.user.nohp = input.replaceFirst(new RegExp(r'^0+'), ''),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText1,
                                letterSpacing: 0.1,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 500),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText1,
                                  letterSpacing: 0.1,
                                  color: themeData.colorScheme.onBackground,
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
                              prefixIcon: Icon(Icons.lock_outline),
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _con.hidePassword = !_con.hidePassword;
                                  });
                                },
                                icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                              ),
                              contentPadding: EdgeInsets.all(0),
                            ),
                            obscureText: _con.hidePassword,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _con.user.password = input,
                            validator: (input) => input.length < 3 ? 'Password Kurang Dari 3 Karakter' : null,
                          ),
                      ),
                      
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                          boxShadow: [
                            BoxShadow(
                              color: themeData.primaryColor.withAlpha(24),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 24),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(Spacing.xy(20, 0))
                          ),
                          onPressed: () {
                            _con.login();
                          },
                          child: Text("Login Sekarang",
                            style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,fontWeight: 600).merge(TextStyle(color: themeData.colorScheme.onPrimary)),
                          ),
                        ),
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
    // String patttern = ;
    // RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (value.length == 0) {
          return 'Masukan No Ponsel';
    }
    // else if (!regExp.hasMatch(value)) {
    //       return 'No Ponsel Salah';
    // }
    return null;
  }

}
