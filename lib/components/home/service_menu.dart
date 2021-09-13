import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceMenu extends StatelessWidget {
  const ServiceMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 27),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ServiceMenuBTN(
                svgpath: "assets/icons/simpanan_icon.svg",
                text: "Simpanan",
                onpress: () {
                  Navigator.of(context).pushNamed('/Simpanan');
                },
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/transfer_simp_icon.svg",
                text: "Transfer",
                onpress: () {},
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/pembiayaan_icon.svg",
                text: "Pembiayaan",
                onpress: () {
                  Navigator.of(context).pushNamed('/Pembiayaan');
                },
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/shu_icon.svg",
                text: "SHU",
                onpress: () {
                  Navigator.of(context).pushNamed('/SHU');
                },
              ),
            ],
          ),
          SizedBox(height: 23),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ServiceMenuBTN(
                svgpath: "assets/icons/pulsa_icon.svg",
                text: "Pulsa",
                onpress: () {
                  Navigator.of(context).pushNamed('/PulsaData', arguments: RouteArgument(id: 'pulsa'));
                },
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/paketdata_icon.svg",
                text: "Paket Data",
                onpress: () {
                  Navigator.of(context).pushNamed('/PulsaData', arguments: RouteArgument(id: 'data'));
                },
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/pln_icon.svg",
                text: "PLN",
                onpress: () {},
              ),
              ServiceMenuBTN(
                svgpath: "assets/icons/lainnya_icon.svg",
                text: "Lainnya",
                onpress: () {
                  Navigator.of(context).pushNamed('/Lainnya');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ServiceMenuBTN extends StatelessWidget {
  final Function onpress;
  final String svgpath;
  final String text;
  const ServiceMenuBTN({
    Key key,
    this.svgpath,
    this.text,
    this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
      onTap: onpress,
      child: Container(
        width: (MediaQuery.of(context).size.width - 72) / 4,
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              svgpath,
              height: 45,
            ),
            SizedBox(height: 4),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                )
            )
          ],
        ),
      )
    );
  }
}
