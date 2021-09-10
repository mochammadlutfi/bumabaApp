import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:bumaba/Modules/Transaksi/transaksi_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'simpanan_model.dart';

import '../../Core/helper.dart';

import '../User/user_model.dart';
import '../User/user_repository.dart' as userRepo;

Future<Stream<Simpanan>> getSimpananList() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final Uri uri = Helper.getUri('api/simpanan');
  final String _apiToken = 'Bearer ${_user.apiToken}';

  final client = new http.Client();
  final request = http.Request('get', uri);
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  // print(uri);
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Simpanan.fromJSON(data);
  });
}

Future<Stream<Simpanan>> getSimpananDetail(String slug) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/simpanan/$slug');
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
    return Simpanan.fromJSON(data);
  });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Simpanan.fromJSON({}));
  }
}

Future<Stream<Transaksi>> getRiwayatSimpanan(String slug) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}simpanan/$slug/riwayat';

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

  
Future<Stream<TagihanSimpanan>> getTagihanSimpananDetail(String slug) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/tagihan/simpanan/$slug');
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
    return TagihanSimpanan.fromJSON(data);
  });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new TagihanSimpanan.fromJSON({}));
  }
}
