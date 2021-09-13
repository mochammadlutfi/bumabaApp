import 'package:bumaba/Config/color.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/simpanan_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';



import '../../route_argument.dart';

// ignore: must_be_immutable
class TagihanSimpananDetailPage extends StatefulWidget {
  RouteArgument routeArgument;

  TagihanSimpananDetailPage({Key key, this.routeArgument}) : super(key: key);
  
  @override
  _TagihanSimpananDetailPageState createState() {
    return _TagihanSimpananDetailPageState();
  }
}

class _TagihanSimpananDetailPageState extends StateMVC<TagihanSimpananDetailPage> {
  // ignore: unused_field
  SimpananController _con;
  Map param = {};
  final DateFormat formatter = DateFormat('dd-mm-Y');
  _TagihanSimpananDetailPageState() : super(SimpananController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenDetailTagihan(slug: widget.routeArgument.id);
     initializeDateFormatting();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: Text("Tagihan Simpanan",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700,
                color: Colors.white,
                )
        ),
      ),
      body: _con.tagihan == null ? CircularLoadingWidget(height: size.height /2 ): 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
            Container(
              width: size.width,
              color: mainColor,
              padding: EdgeInsets.only(top: 15),
              height: size.height * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Tagihan ' + _con.tagihan.service,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Rp",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                          )
                      ),
                      SizedBox(width: 5),
                      Text(NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(_con.tagihan.nominal),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[1]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text("Jumlah Tunggakan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  Text(_con.tagihan.jumlah + " Bulan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              )
            ),
              
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                          childAspectRatio: 5/2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8
                      ),
                      itemCount: _con.tagihan.tunggakan.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _con.ontagihanSelected( _con.tagihan.tunggakan[index]);
                          },
                          child: Card(
                            shape: ( _con.tagihanSelected.contains(_con.tagihan.tunggakan[index]))
                                ? RoundedRectangleBorder(side: BorderSide(color: Colors.green))
                                : null,
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Periode",
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(_con.tagihan.tunggakan[index])
                                ],
                              ),
                            )
                          ),
                        );
                      },
                    ),
                ),
              ),
            ],
          ),
      
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Pembayaran'),
                SizedBox(height: 6,),
                Text(NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(_con.totalBayar).toString(), 
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              width: size.width/3,
              height: 40,
              child: ElevatedButton(
                onPressed: (_con.tagihanSelected.length <= 0) ? null : (){
                  Map parameter = {
                    'nominal' : _con.totalBayar,
                    'slug' : 'deposit', 
                    'service' : 'wajib', 
                    'tagihan_id' : _con.tagihanSelected,
                    'title' : 'Setor Simpanan Wajib'
                  };
                  Navigator.of(context).pushNamed('/PaymentMethod', arguments: RouteArgument(param : parameter));
                },
                child: Text('Lanjut', style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xFF0d9437);
                      else if (states.contains(MaterialState.disabled))
                        return Color(0xFF0c5824);
                      return Color(0xFF0d9437);
                    },
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TagihanItem extends StatelessWidget {
  final String tagihan;
  final Checkbox checkbox;
  TagihanItem({
    Key key,
    this.tagihan,
    this.checkbox
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(6)),
        boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(2, 2),
              blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3, color: bodylight),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: checkbox,
                ),
                Text(tagihan.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

