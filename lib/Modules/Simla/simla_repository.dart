import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/Modules/Simla/simla_model.dart';
// ignore: unused_import
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../User/user_model.dart';
import '../User/user_repository.dart' as userRepo;


ValueNotifier<int> currentSaldo = new ValueNotifier(0);

Future<int> getSimlaSaldo() async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}simla';
  final client = new http.Client();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
  );
    if (response.statusCode == 200) {
     currentSaldo.value = json.decode(response.body)['data'];
     setSaldoSimla(json.decode(response.body)['data']);
      currentSaldo.notifyListeners();
    } else {
      throw new Exception(json.decode(response.body)['message']);
    }
  return currentSaldo.value;
}

void setSaldoSimla(saldo) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('current_saldo', saldo);
}

Future<int> getCurrentSaldo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (currentSaldo.value == null && prefs.containsKey('current_saldo')) {
    // ignore: await_only_futures
    currentSaldo.value = await prefs.get('current_saldo');
  }
  currentSaldo.notifyListeners();
  return currentSaldo.value;
}

Future<Stream<Transaksi>> getRiwayat() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}simla/riwayat';

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

Future<User> cekAnggota(String angotaId) async {
  User data = new User();
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}anggota/?phone=$angotaId';
  final client = new http.Client();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
  );
  if (response.statusCode == 200) {
    data = User.fromJSON(json.decode(response.body)['data']);
    return data;
  } else {
    throw new Exception(json.decode(response.body)['message']);
  }
}

Future<String> transfer(Simla transfer) async {
  Transaksi data = new Transaksi();
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}simla/transfer';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
    },
    body: json.encode(transfer.toTransferMap()),
  );
  if (response.statusCode == 200) {
    data = Transaksi.fromJSON(json.decode(response.body)['data']);
    return data.id;
  } else {
    throw new Exception(json.decode(response.body));
  }
}