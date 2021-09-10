import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key key,
    @required this.nama,
    @required this.nohp
  }) : super(key: key);

  final String nama;
  final String nohp;

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
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                SvgPicture.asset(
                    "assets/icons/profile.svg",
                    height: 33,
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.nama,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(this.nohp,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
