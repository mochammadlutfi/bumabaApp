import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'pembiayaan_model.dart';

import '../../Core/helper.dart';

import '../User/user_model.dart';
import '../User/user_repository.dart' as userRepo;

// ignore: non_constant_identifier_names
ValueNotifier<Pembiayaan> current_pengajuan = new ValueNotifier(Pembiayaan());

Future<Stream<PembiayaanList>> getPembiayaanList() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final Uri uri = Helper.getUri('api/pembiayaan');
  final String _apiToken = 'Bearer ${_user.apiToken}';

  final client = new http.Client();
  final request = http.Request('get', uri);
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return PembiayaanList.fromJSON(data);
  });
}

Future<Stream<PembiayaanList>> getPembiayaanListDetail(String slug) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/pembiayaan/$slug');
  final String _apiToken = 'Bearer ${_user.apiToken}';
  // print(uri);
  try {
    final client = new http.Client();
    final request = http.Request('get', uri);
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) {
    // print(data);
    return PembiayaanList.fromJSON(data);
  });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new PembiayaanList.fromJSON({}));
  }
}

Future<Stream<Pembiayaan>> getPembiayaanDetail(String slug, String id) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/pembiayaan/$slug/detail/$id');
  final String _apiToken = 'Bearer ${_user.apiToken}';
  print(uri);
  try {
    final client = new http.Client();
    final request = http.Request('get', uri);
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) {
    // print(data);
    return Pembiayaan.fromJSON(data);
  });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Pembiayaan.fromJSON({}));
  }
}

Future<Pembiayaan> pengajuanTunai(Pembiayaan pengajuan) async {
  User _user = userRepo.currentUser.value;

  final String url = '${GlobalConfiguration().getString('api_base_url')}pembiayaan/pengajuan';
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
    },
    body: json.encode(pengajuan.toMap()),
  );
  if (response.statusCode == 200) {
    current_pengajuan.value = Pembiayaan.fromJSON(json.decode(response.body)['data']);
    return current_pengajuan.value;
  } else {
   
    throw new Exception(response.body);
  }
}

Future<Stream<PembiayaanDetail>> getTagihanPembiayaanList(String slug) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final Uri uri = Helper.getUri('api/pembiayaan/$slug/tagihan');
  final String _apiToken = 'Bearer ${_user.apiToken}';

  final client = new http.Client();
  final request = http.Request('get', uri);
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return PembiayaanDetail.fromJSON(data);
  });
}
