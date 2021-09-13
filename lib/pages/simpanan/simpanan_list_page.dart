
import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/simpanan_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';


import '../../route_argument.dart';


import '../../models/simpanan_model.dart';

class SimpananPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SimpananPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SimpananPageState createState() => _SimpananPageState();
}

class _SimpananPageState extends StateMVC<SimpananPage> {
  SimpananController _con;

  _SimpananPageState() : super(SimpananController()) {
    _con = controller;                                                                                                                                          
  }

  // @override
  void initState() {
    _con.listenForSimpanan();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.customTheme.bgLayer1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
          ),
        ),
        title: Text("Program Simpanan",
            style: AppTheme.getTextStyle(
                Theme.of(context).textTheme.headline6,
                fontWeight: 700)
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 17, 22, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progam Simpanan",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RefreshIndicator(
                onRefresh: _con.refreshList,
                child: _con.simpanan.isEmpty ? 
                CircularLoadingWidget(height: 500) : 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.simpanan.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SimpananItem(simpanan: _con.simpanan.elementAt(index));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpananItem extends StatelessWidget {
  final Simpanan simpanan;
  
  const SimpananItem({
    Key key,
    this.simpanan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.white,
            // border: Border(
            //   left: BorderSide(
            //     color: mainColor,
            //     width: 3.0,
            //   ),
            // ),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell( 
              splashColor: Colors.white30,
              onTap: (){
                Map parameter = {
                  'slug' : simpanan.slug,
                  'program' : simpanan.program,
                };
                Navigator.of(context).pushNamed('/SimpananDetail', arguments: new RouteArgument(param: parameter));
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(simpanan.program,
                            style: TextStyle(fontSize: 16, fontWeight : FontWeight.w700, color: blacktext),
                          ),
                          SizedBox(height: 8),
                          Text(simpanan.saldo,
                            style: TextStyle(fontSize: 14, fontWeight : FontWeight.w600, color: blacktext),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.grey,
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}



