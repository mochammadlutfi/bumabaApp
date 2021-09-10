import 'dart:convert';
import 'dart:io';
import 'package:bumaba/Core/custom_trace.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import 'transaksi_model.dart';

import '../../Core/helper.dart';

import '../User/user_model.dart';
import '../User/user_repository.dart' as userRepo;


ValueNotifier<Transaksi> currentTransaksi = new ValueNotifier(Transaksi());

Future<Stream<Transaksi>> getTransaksiList(String status, int page, int limit) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}transaksi?status='+ status +'&page='+page.toString();
  final client = new http.Client();
  final request = http.Request('get', Uri.parse(url));
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Transaksi.fromJSON(data);
  });
}

Future<Stream<Transaksi>> getTransaksiDetail(String id) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/transaksi/detail/$id');
  final String _apiToken = 'Bearer ${_user.apiToken}';
  try {
    final client = new http.Client();
    final request = http.Request('get', uri);
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
    final streamedRest = await client.send(request);
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) {
      return Transaksi.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Transaksi.fromJSON({}));
  }
}


Future<Transaksi> simlaTopup(Transaksi payment) async {
  User _user = userRepo.currentUser.value;

  final String url = '${GlobalConfiguration().getString('api_base_url')}simla/topup';
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
    },
    body: json.encode(payment.toPayMap()),
  );
  print(response.body);
  if (response.statusCode == 200) {
    currentTransaksi.value = Transaksi.fromJSON(json.decode(response.body)['data']);
    return currentTransaksi.value;
  } else {
    throw new Exception(response.body);
  }
}


Future<Transaksi> confirm(String id) async {
  User _user = userRepo.currentUser.value;

  Map data = { "id" : id };

  final String url = '${GlobalConfiguration().getString('api_base_url')}simla/confirm';
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
    },
    body: json.encode(data),
  );
  print(response.body);
  if (response.statusCode == 200) {
    currentTransaksi.value = Transaksi.fromJSON(json.decode(response.body)['data']);
    return currentTransaksi.value;
  } else {
   
    throw new Exception(response.body);
  }
}
