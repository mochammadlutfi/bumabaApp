
import 'package:bumaba/Config/color.dart';
// ignore: unused_import
import 'package:bumaba/Modules/Simpanan/simpanan_controller.dart';
import 'package:bumaba/Modules/Transaksi/components/transaksi_empty.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_controller.dart';
import 'package:bumaba/components/loading/loading_circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../transaksi_model.dart';
import 'transaksi_list_item.dart';


// ignore: must_be_immutable
class TransaksiList extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  String status;
  TransaksiList({Key key, this.parentScaffoldKey, this.status}) : super(key: key);

  @override
  _TransaksiListState createState() => _TransaksiListState();
}

class _TransaksiListState extends StateMVC<TransaksiList> {
  TransaksiController _con;

  // final PagingController<int, Transaksi> _pagingController = PagingController(firstPageKey: 0);
  
  _TransaksiListState() : super(TransaksiController()) {
    _con = controller;                                                                                                                                          
  }

  // @override
  void initState() {
    _con.setState(() {
      _con.statusTransaksi = widget.status;
    });
    _con.pagingController.addPageRequestListener((pageKey) {
      _con.listenListTransaksi(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _con.pagingController.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
        color: mainColor,
        onRefresh: () => Future.sync(
          () => _con.pagingController.refresh(),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: PagedListView<int, Transaksi>(
            pagingController: _con.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Transaksi>(
              itemBuilder: (context, item, index) => TransaksiListItem(transaksi: item),
              firstPageProgressIndicatorBuilder: (_) => CircularLoadingWidget(height: size.height /2),
              newPageProgressIndicatorBuilder: (_) => CircularLoadingWidget(height: 80),
              noItemsFoundIndicatorBuilder: (_) => TransaksiEmpty()
            ),
          ),
        )
      );
  }
}


