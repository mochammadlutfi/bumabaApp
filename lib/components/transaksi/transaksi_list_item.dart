import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Config/color.dart';
import '../../route_argument.dart';
import '../../models/transaksi_model.dart';

class TransaksiListItem extends StatelessWidget {
  final Transaksi transaksi;
  final String slug;
  const TransaksiListItem({
    Key key,
    this.transaksi,
    this.slug
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {

          transaksi.payment.status == 'Menunggu Pembayaran' && transaksi.hasPaid == 0 ?
          Navigator.of(context).pushNamed('/PaymentConfirm', arguments: new RouteArgument(param : {"id" : transaksi.id, "value" : "null"})) :
          Navigator.of(context).pushNamed('/TransaksiDetail', arguments: new RouteArgument(id: transaksi.id, param : slug));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaksi.jenis,
                    style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                  ),
                  SizedBox(height: 6),
                  Text(transaksi.tgl,
                    style: TextStyle(fontSize: 13, fontWeight : FontWeight.w400, color: blacktext),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(NumberFormat.currency(locale : 'id', symbol : 'Rp', decimalDigits: 0).format(transaksi.jumlah).toString(),
                    style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                  ),
                  SizedBox(height: 6),
                  Text(transaksi.payment.status,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight : FontWeight.w600, 
                      color: getStatusColor(transaksi.payment.status)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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