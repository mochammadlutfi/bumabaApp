
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Tagihan/tagihan_controller.dart';
import 'package:bumaba/Modules/Tagihan/tagihan_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../route_argument.dart';


// ignore: must_be_immutable
class ListTagihanSimpanan extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  List<Tagihan> tagihan = <Tagihan>[];

  ListTagihanSimpanan({Key key, this.parentScaffoldKey, this.tagihan}) : super(key: key);

  @override
  _ListTagihanSimpananState createState() => _ListTagihanSimpananState();
}

class _ListTagihanSimpananState extends StateMVC<ListTagihanSimpanan> {
  TagihanController _con;

  _ListTagihanSimpananState() : super(TagihanController()) {
    _con = controller;                                                                                                                                          
  }

  // @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return widget.tagihan.isEmpty ? CircularLoadingWidget(height: size.height /2) : 
      RefreshIndicator(
        color: mainColor,
        onRefresh: _con.refreshSimpanan,
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(17, 10, 17, 10),
          child:  widget.tagihan.isEmpty ? 
            Text('Data Kosong') : 
            ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.tagihan.length,
            itemBuilder: (BuildContext context, int index) {
              return TagihanItem(tagihan: widget.tagihan.elementAt(index));
            },
          ),
        ),
      );

  }
}


class TagihanItem extends StatelessWidget {
  final Tagihan tagihan;
  const TagihanItem({
    Key key,
    this.tagihan,
    // this.slug
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: Material(
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 6.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(6))
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              onTap: (){
                Navigator.of(context).pushNamed('/TagihanSimpananDetail', arguments: new RouteArgument(id: tagihan.subService));
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Text(tagihan.service == '' ? "Program" : tagihan.service,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                        ),
                        SizedBox(
                          height: 16.0,
                          child: new Center(
                            child: new Container(
                              // margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Lama Tagihan",
                              style: TextStyle(fontSize: 14.0)
                            ),

                            Text(tagihan.jumlah == '' ? "Bulan" : '${tagihan.jumlah} Bulan',
                              style: TextStyle(fontSize: 14)
                            ),
                            // Text("Jumlah Tunggakan",style: TextStyle(fontSize: 14.0,)),
                          ],
                        ),
                        SizedBox(height : 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jumlah Tagihan",
                              style: TextStyle(fontSize: 14.0)
                            ),

                            Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(tagihan.nominal).toString(),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                            ),
                            // Text("Jumlah Tunggakan",style: TextStyle(fontSize: 14.0,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


