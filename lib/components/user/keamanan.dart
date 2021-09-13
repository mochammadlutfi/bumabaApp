import 'package:flutter/material.dart';

class SecurityApp extends StatelessWidget {
  const SecurityApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(17, 17, 17, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Keamanan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 6),
                ListBtn(
                  text: "Ubah Security Code",
                  ontap: (){
                    Navigator.of(context).pushNamed('/PinChange');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class ListBtn extends StatelessWidget {
  final String text;
  final VoidCallback ontap;

  const ListBtn({
    Key key,
    this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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

