import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Config/color.dart';

class TransaksiEmpty extends StatelessWidget {

  const TransaksiEmpty({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/img/transaksi_empty.svg",
            height: 200,
          ),Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text("Transaksi Tidak Ditemukan!",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
            ),
        ],
      ),
    );
  }
}

getStatusColor(String status){
  if(status == 'Verifikasi' || status == 'Menunggu Pembayaran'){
    return orangetext;
  }else if(status == 'Berhasil'){
    return mainColor;
  }
}