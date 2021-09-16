import 'package:bumaba/repository/simla_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../Config/color.dart';

// ignore: must_be_immutable
class SimlaService extends StatelessWidget {

  SimlaService({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(19, 10, 19, 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: Offset(2, 2),
                blurRadius: 10),
          ]
        ),
      child: Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
              color: const Color(0xfff6f6f6),
              borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(6),
                topRight: new Radius.circular(6)
              )
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
            text: TextSpan(
                style:
                    TextStyle(color: blacktext, fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(text: "Saldo Sukarela", style: TextStyle(fontSize: 16))
                ]),
          ),
                new Container(
                  child: Text(
                    NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp').format(currentSaldo.value).toString(),
                    style: TextStyle(
                        fontSize: 14.0,),
                  ),
                )
              ],
            ),
          ),
          new Container(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TopupBTN(
                  iconpath: "assets/icons/topup_icon.svg",
                  text: "Top Up",
                  onpress: () {
                      Navigator.of(context).pushNamed('/TopUp');
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => TopUpPage()));
                  },
                ),
                TopupBTN(
                  iconpath: "assets/icons/transfer_icon.svg",
                  text: "Transfer",
                  onpress: () {
                      Navigator.of(context).pushNamed('/SimlaTransfer');
                  },
                ),
                TopupBTN(
                  iconpath: "assets/icons/history_icon.svg",
                  text: "Riwayat",
                  onpress: () {
                      Navigator.of(context).pushNamed('/SimlaRiwayat');
                  },
                ),
              ],
            ),
            )
        ],
      )
    );
  }
}

class TopupBTN extends StatelessWidget {
  final Function onpress;
  final String iconpath;
  final String text;

  const TopupBTN({
    Key key,
    this.iconpath,
    this.text,
    this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 12),
        child: Container(
          color: Colors.white,
          width: (MediaQuery.of(context).size.width - 38) / 4,
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                iconpath,
                height: 26,
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: mainColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
