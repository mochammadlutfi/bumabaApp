import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Config/color.dart';

class ListService extends StatelessWidget {
  const ListService({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              children: [
                ListButton(
                  icon: "assets/icons/simpanan_icon.svg",
                  nama: "Simpanan",
                  ontap: (){},
                ),
                ListButton(
                  icon: "assets/icons/pembiayaan_icon.svg",
                  nama: "Pembiayaan",
                  ontap: (){},
                ),
                ListButton(
                  icon: "assets/icons/shu_icon.svg",
                  nama: "Simpanan Sosial",
                  ontap: (){},
                ),
                ListButton(
                  icon: "assets/icons/pulsa_icon.svg",
                  nama: "Pulsa",
                  ontap: (){},
                ),
                ListButton(
                  icon: "assets/icons/paketdata_icon.svg",
                  nama: "Paket Data",
                  ontap: (){},
                ),
                ListButton(
                  icon: "assets/icons/pln_icon.svg",
                  nama: "PLN",
                  ontap: (){},
                ),
              ],
            ),
        ],
      ),
    );
  }
}


class ListButton extends StatelessWidget {
  final String nama;
  final String icon;
  final Function ontap;
  
  const ListButton({
    Key key,
    this.nama,
    this.icon,
    this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 5),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: bodylight,
                width: 1.0,
              ),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 0.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: ontap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical : 20, horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(icon),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        nama,
                        style: TextStyle(fontSize: 16),
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
            ),
          ),
        ),
      ),
    );
  }
}
