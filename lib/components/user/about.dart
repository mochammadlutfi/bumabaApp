import 'package:bumaba/Config/color.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(17, 17, 17, 21),
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
                  "Tentang",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 6),
                ListBtn(
                  text: "Keuntungan Anggota BUMABA",
                ),
                ListBtn(
                  text: "Panduan Penggunaan",
                ),
                ListBtn(
                  text: "Syarat & Ketentuan",
                ),
                ListBtn(
                  text: "Kebijakan Privasi",
                ),
                ListBtn(
                  text: "Pusat Bantuan",
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
  const ListBtn({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){ },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: bodylight),
          ),
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

