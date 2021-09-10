
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Simla/simla_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



// import '../elements/BlockButtonWidget.dart';
// import '../repository/user_repository.dart' as userRepo;
// import 'Repository/SettingRepository.dart' as settingsRepo;
// import 'elements/HomeSlider/HomeSliderWidget.dart';
// import 'elements/Category/CaregoriesCarouselWidget.dart';

// import 'elements/Toko/TokoListWidget.dart';

class TopUpPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TopUpPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends StateMVC<TopUpPage> {
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(locale: 'id',decimalDigits: 0,symbol: 'Rp',);
  int nominal = 0;
  SimlaController _con;
  _TopUpPageState() : super(SimlaController()) {
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
      appBar: new AppBar(
        leading: BackButton(
          color: Colors.white
        ), 
        titleSpacing: 0,
        title: Text('Isi Saldo', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _con.formTopUp,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:16),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 17, 20, 21),
                color: Colors.white,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nominal Saldo",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10,),
                    
                      TextFormField(
                          validator: (value) {
                            if(value.isNotEmpty){
                              int jumlah = int.parse(value.replaceAll(new RegExp(r'\D'),''));
                              if (jumlah < 10000) {
                                  return 'Jumlah Isi Saldo Minimal Rp10.000';
                              }
                            }else{
                              return 'Jumlah Isi Saldo Wajib Diisi!';
                            }
                            return null;
                          },
                          inputFormatters: [_formatter],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Rp0',
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                          onChanged:(value){
                          nominal = value.isNotEmpty ? int.parse(value.replaceAll(new RegExp(r'\D'),'')) : 0;
                          setState(() {
                              _con.nominal = nominal;
                          });
                        },
                      ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: TextButton(
                        onPressed: (){
                          _con.simpanTopUp();
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
      ),
    );
  }
}


