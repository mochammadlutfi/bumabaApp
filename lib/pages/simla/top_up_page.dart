import 'package:bumaba/components/keyboard/keyboard_key_widget.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/simla_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';

class TopUpPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TopUpPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends StateMVC<TopUpPage> {
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(locale: 'id',decimalDigits: 0,symbol: 'Rp',);
  int nominal = 0;
  List<List<dynamic>> keys;
  String amount = '';

  SimlaController _con;
  _TopUpPageState() : super(SimlaController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    super.initState();
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['00', '0', Icon(Icons.keyboard_backspace, color: Colors.black,)],
    ];

    amount = '';
  }

  onKeyTap(val) {
    if(val == '0' && amount.length == 0){
      return;
    }

    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress() {
    if (amount.length == 0) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                return Expanded(
                  child: KeyboardKeyWidget(
                    label: y,
                    value: y,
                    onTap: (val) {
                      if (val is Widget) {
                        onBackspacePress();
                      } else {
                        onKeyTap(val);
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }
  
  renderAmount() {
    String display = '123';
    TextStyle style = TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (this.amount.isNotEmpty && this.amount.length > 0) {
      NumberFormat f = NumberFormat('#,###');

      display = f.format(int.parse(amount));
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  renderConfirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: amount.length > 0 ? Colors.green : Colors.grey[200],
                  minimumSize: Size(100, 50),
              ),
              onPressed: amount.length > 0 ? (){
                simpanTopUp();
              } : null,
              child: Text(
                  'Lanjutkan',
              style: TextStyle(
                color: amount.length > 0 ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ),
        ],
      ),
    );
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
        title: Text("Top UP Saldo",
            style: AppTheme.getTextStyle(
                themeData.textTheme.headline6,
                fontWeight: 700)),
      ),
      key: _con.scaffoldKey,
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width : MediaQuery.of(context).size.width,
              height : MediaQuery.of(context).size.height /2.5,
              color : AppTheme.customTheme.bgLayer1,
              margin: EdgeInsets.symmetric(vertical : 10),
              padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: Column(
                mainAxisAlignment : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jumlah Isi Saldo"),
                  SizedBox(height: 5,),
                  Text(_formatter.format(amount), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child : Container(
                width : MediaQuery.of(context).size.width,
                color : AppTheme.customTheme.bgLayer1,
                margin: EdgeInsets.symmetric(vertical : 10),
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...renderKeyboard(),
                    renderConfirmButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void simpanTopUp() async{
    FocusScope.of(context).unfocus();
    nominal = amount.length > 1 ? int.parse(amount) : 0;
    if(nominal < 10000){
      Fluttertoast.showToast(msg: 'Jumlah Minimal Isi Saldo Rp10.000');
    }else{
      Map parameter = {
        'nominal' : nominal,
        'slug' : 'simla', 
        'service' : 'Simpanan Sukarela',
        'title' : 'Isi Saldo Simpanan Sukarela'
      };
      Navigator.of(context).pushNamed('/PaymentMethod', arguments: RouteArgument(param : parameter));
    }
  }

}


