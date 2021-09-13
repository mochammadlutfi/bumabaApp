import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
import '../../Config/color.dart';
import '../../route_argument.dart';

class ListSimpanan extends StatelessWidget {
  const ListSimpanan({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(19, 20, 19, 58),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: [
                SimpananBTN(
                  icon: "assets/icons/KartuDebit.svg",
                  program: "Simpanan Pokok",
                  saldo: "Rp 200.000",
                  ontap: () {
                      Navigator.of(context).pushNamed('/SimpananDetail', arguments: new RouteArgument(id: "pokok"));
                  },
                ),
                SimpananBTN(
                  icon: "assets/icons/Bank.svg",
                  program: "Simpanan Wajib",
                  saldo: "Rp 400.000",
                  ontap: () {
                      Navigator.of(context).pushNamed('/SimpananDetail', arguments: new RouteArgument(id: "wajib"));
                  },
                ),
                SimpananBTN(
                  icon: "assets/icons/mobilebanking.svg",
                  program: "Simpanan Sosial",
                  saldo: "Rp 20.000",
                  ontap: () {
                      Navigator.of(context).pushNamed('/SimpananDetail', arguments: new RouteArgument(id: "sosial"));
                  },
                ),
                SimpananBTN(
                  icon: "assets/icons/ovobooth.svg",
                  program: "Simpanan Sukarela",
                  saldo: "Rp 700.000",
                  ontap: () {
                      Navigator.of(context).pushNamed('/SimpananDetail', arguments: new RouteArgument(id: "sukarela"));
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}


class SimpananBTN extends StatelessWidget {
  final String program;
  final String icon;
  final String saldo;
  final Function ontap;
  
  const SimpananBTN({
    Key key,
    this.program,
    this.icon,
    this.saldo,
    this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 6.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: mainColor,
                width: 3.0,
              ),
            ),
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
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(program,
                            style: TextStyle(fontSize: 16, fontWeight : FontWeight.w700, color: blacktext),
                          ),
                          SizedBox(height: 8),
                          Text(saldo,
                            style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                          ),
                        ],
                      ),
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
