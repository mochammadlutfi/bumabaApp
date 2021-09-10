import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotifikasiList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new TextEditingController(text: "OVO Cash");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          //Top up makin mudah
          Container(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Text(
              "Top up makin mudah dengan metode berikut:",
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              margin: EdgeInsets.symmetric(horizontal: 35),
              color: Colors.grey[100],
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
          )
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      margin: EdgeInsets.only(bottom: 8),
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
    );
  }
}
