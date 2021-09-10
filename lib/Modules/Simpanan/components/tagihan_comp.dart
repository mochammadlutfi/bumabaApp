
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Config/color.dart';
import '../simpanan_model.dart';

class TagihanComp extends StatelessWidget {
  final TagihanSimpanan tagihan;
  final VoidCallback ontap;

  const TagihanComp({
    Key key,
    this.tagihan,
    this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child:  Text("Tunggakan " +tagihan.jumlah + " Bulan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
            ),
            Divider(
              thickness : 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits:0).format(tagihan.nominal).toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight : FontWeight.bold,
                    ),
                  ),

                  // if(_con.listDetail?.jumlahTagihan != 0)
                  Container(
                    height: 26,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: ontap,
                      child: Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                      ),
                    ),
                  ),

                ],
                
              ),
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