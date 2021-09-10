import 'package:bumaba/Config/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pembiayaan_model.dart';

// ignore: must_be_immutable
class TagihanItemComponent extends StatelessWidget {
  PembiayaanDetail tagihan;
  // final Onchange;
  final Function onchange;
  TagihanItemComponent({this.tagihan, this.onchange});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(6)),
        boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(2, 2),
              blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3, color: bodylight),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text("Angsuran Ke " + tagihan.angsuranke.toString(),
                //   style: TextStyle(fontSize: 12),
                // ),
                Text(tagihan.nomor,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Angsuran Ke " + tagihan.angsuranke.toString(),
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(tagihan.jumlahAngsuran).toString(),
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jatuh Tempo ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(tagihan.tempo,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}