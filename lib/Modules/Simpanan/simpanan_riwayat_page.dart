
import 'package:bumaba/Modules/Simpanan/simpanan_controller.dart';
import 'package:bumaba/Modules/Transaksi/components/transaksi_empty.dart';
import 'package:bumaba/Modules/Transaksi/components/transaksi_list_item.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../route_argument.dart';
import '../Main/main_app_bar.dart';

// ignore: must_be_immutable
class SimpananRiwayatPage extends StatefulWidget {
  RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SimpananRiwayatPage({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _SimpananRiwayatPageState createState() => _SimpananRiwayatPageState();
}

class _SimpananRiwayatPageState extends StateMVC<SimpananRiwayatPage> {
  SimpananController _con;

  _SimpananRiwayatPageState() : super(SimpananController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    // _con.listenRiwayatTransaksi(slug: widget.routeArgument.id);
    _con.pagingController.addPageRequestListener((pageKey) {
      _con.listenRiwayatTransaksi(pageKey, widget.routeArgument.id);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: mainappbar('Riwayat Transaksi'),
      body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 17, 22, 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Riwayat Transaksi",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin : EdgeInsets.symmetric(vertical: 10),
                child: PagedListView<int, Transaksi>(
                  pagingController: _con.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Transaksi>(
                    itemBuilder: (context, item, index) => TransaksiListItem(transaksi: item),
                    firstPageProgressIndicatorBuilder: (_) => CircularLoadingWidget(height: size.height /2),
                    newPageProgressIndicatorBuilder: (_) => CircularLoadingWidget(height: 80),
                    noItemsFoundIndicatorBuilder: (_) => TransaksiEmpty()
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
