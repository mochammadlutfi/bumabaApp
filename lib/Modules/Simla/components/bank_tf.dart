import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PilihBankTransfer extends StatelessWidget {
  const PilihBankTransfer({
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
          Text(
            "Transfer Bank",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 10),
          Column(
              children: [
                MetodeBTN(
                  icon: "assets/icons/KartuDebit.svg",
                  text: "Kartu Debit",
                ),
                MetodeBTN(
                  icon: "assets/icons/Bank.svg",
                  text: "ATM",
                ),
                MetodeBTN(
                  icon: "assets/icons/mobilebanking.svg",
                  text: "Internet / Mobile Banking",
                ),
                MetodeBTN(
                  icon: "assets/icons/ovobooth.svg",
                  text: "OVO Booth",
                ),
                MetodeBTN(
                  icon: "assets/icons/logograb.svg",
                  text: "Grab",
                ),
              ],
            ),
        ],
      ),
    );
  }
}


class MetodeBTN extends StatelessWidget {
  final String text;
  final String icon;
  const MetodeBTN({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){ },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        margin: EdgeInsets.only(bottom: 4),
        color: Colors.white,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14),
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
    );
  }
}
