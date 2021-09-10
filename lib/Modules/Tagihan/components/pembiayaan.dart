import 'package:bumaba/Modules/Main/components/detail_field.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';

class TagihanPembiayaan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new TextEditingController(text: "OVO Cash");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              margin: EdgeInsets.symmetric(horizontal: 35),
              color: Colors.grey[100],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                        color: const Color(0xfff6f6f6),
                        borderRadius: new BorderRadius.only(
                          bottomLeft: new Radius.circular(6),
                          bottomRight: new Radius.circular(6)
                        )
                      ),
                      child: Column(
                        children: <Widget>[
                            new DetailField(label: "Jumlah Tunggakan", value: "11 Bulan", fontsize : 13, border : true),
                            
                            new DetailField(label: "Nominal", value: "Rp 1500.000", fontsize : 13, border : true)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

