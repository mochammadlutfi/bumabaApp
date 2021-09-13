
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class PLNPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PLNPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PLNPageState createState() => _PLNPageState();
}

class _PLNPageState extends StateMVC<PLNPage> {
  // HomeController _con;

  // _HomePageState() : super(HomeController()) {
  //   _con = controller;                                                                                                                                          
  // }
  // @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: mainappbar("Lainnya"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListButton(
              icon: "assets/icons/pln_icon.svg",
              nama: "PLN Prabayar",
              ontap: (){},
            ),
            ListButton(
              icon: "assets/icons/pln_icon.svg",
              nama: "PLN Pascabayar",
              ontap: (){},
            ),
          ],
        ),
      ),
    );
  }
}


class ListButton extends StatelessWidget {
  final String nama;
  final String icon;
  final Function ontap;
  
  const ListButton({
    Key key,
    this.nama,
    this.icon,
    this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 5),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: bodylight,
                width: 1.0,
              ),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 0.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: ontap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical : 20, horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(icon),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        nama,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 13,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


