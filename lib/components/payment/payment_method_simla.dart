

import 'package:bumaba/Config/color.dart';
import 'package:bumaba/repository/simla_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentMethodSimlaWidget extends StatelessWidget {
  final VoidCallback ontap;
  PaymentMethodSimlaWidget({
    Key key,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
              ),
            ),
            child: Text("BAYAR VIA SIMPANAN SUKARELA",
              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: ontap,
            child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saldo kamu saat ini:'),
                      Text(
                        NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(currentSaldo.value).toString(),
                        style : TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ],
                  )
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                )
              ],
            )
          ),
          ),
        ],
      )
    );
  }
}

