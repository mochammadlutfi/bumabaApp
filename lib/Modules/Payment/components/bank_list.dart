

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../payment_model.dart';

// ignore: must_be_immutable
class BankListComponent extends StatelessWidget {
  final Bank bank;

  VoidCallback ontap;
  // CallBack onpress;
  BankListComponent({
    Key key,
    this.bank,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        shadowColor: Colors.grey[50],
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: ontap,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2, // 60% of space => (6/(6 + 4))
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                        child: Image.network(
                          bank.logo,
                          height: 30,
                        ),
                      )
                    ),
                    
                    Expanded(
                      flex: 4, // 60% of space => (6/(6 + 4))
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          bank.nama,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
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
          ),
        ),
      ),
    );
  }
}

