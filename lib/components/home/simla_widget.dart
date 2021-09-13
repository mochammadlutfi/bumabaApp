import 'package:flutter/material.dart';
import '../../../Config/color.dart';

class SimlaSaldo extends StatelessWidget {
  const SimlaSaldo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
                style:
                    TextStyle(color: mainColor, fontWeight: FontWeight.w600),
                children: <TextSpan>[
                  TextSpan(text: "Simpanan Sukarela ", style: TextStyle(fontSize: 16))
                ]),
          ),
          SizedBox(height: 9),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Rp",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 5),
              Text("70.800",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}
