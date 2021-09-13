
import 'package:bumaba/controllers/pembiayaan_controller.dart';
import 'package:bumaba/models/pembiayaan_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:bumaba/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';

class PembiayaanListPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PembiayaanListPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _PembiayaanListPageState createState() => _PembiayaanListPageState();
}

class _PembiayaanListPageState extends StateMVC<PembiayaanListPage> {

  PembiayaanController _con;

  _PembiayaanListPageState() : super(PembiayaanController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    _con.listenForPembiayaan();
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
        title: Text("Pembiayaan",
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
                  "Progam Pembiayaan",
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
                child: _con.pembiayaanList.isEmpty ? 
                CircularLoadingWidget(height: 500) : 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _con.pembiayaanList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(pembiayaan: _con.pembiayaanList.elementAt(index));
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


class ListItem extends StatelessWidget {
  final PembiayaanList pembiayaan;
  
  const ListItem({
    Key key,
    this.pembiayaan,
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
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(6)),
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
                  'slug' : pembiayaan.slug,
                  'program' : pembiayaan.program,
                };
                Navigator.of(context).pushNamed('/PembiayaanProgram', arguments: new RouteArgument(param: parameter));
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
                          Text(pembiayaan.program,
                            style: TextStyle(fontSize: 16, fontWeight : FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text(pembiayaan.limit,
                            style: TextStyle(fontSize: 15, fontWeight : FontWeight.w700),
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



