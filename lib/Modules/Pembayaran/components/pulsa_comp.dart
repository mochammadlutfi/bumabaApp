import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Config/color.dart';
import '../pulsa_data_model.dart';

class PulsaDataItem extends StatelessWidget {
  final PPOB data;
  final String slug;
  final VoidCallback ontap;

  const PulsaDataItem({
    Key key,
    this.data,
    this.slug,
    this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: ontap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.nama,
                      style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600, color: blacktext),
                    ),
                    SizedBox(height: 6),
                    Text(data.details,
                      style: TextStyle(fontSize: 12, fontWeight : FontWeight.w400, color: blacktext),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text(NumberFormat.currency(locale : 'id', symbol : 'Rp', decimalDigits: 0).format(data.harga).toString(),
                        style: TextStyle(fontSize: 12, fontWeight : FontWeight.w600, color: Colors.white),
                      ),
                    )
                  ],
                ),
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