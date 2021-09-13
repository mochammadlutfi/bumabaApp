import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/payment_model.dart';

import '../models/user_model.dart';
import 'user_repository.dart' as userRepo;

// ignore: non_constant_identifier_names
ValueNotifier<Payment> current_topup = new ValueNotifier(Payment());


Future<Stream<Bank>> getBankList() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}payment/bank';

  final client = new http.Client();
  final request = http.Request('get', Uri.parse(url));
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Bank.fromJSON(data);
  });
}

Future<Payment> pay(Payment payment) async {
  User _user = userRepo.currentUser.value;
  String url;
  Map body;
  if(payment.slug == 'ppob'){
    url = '${GlobalConfiguration().getString('api_base_url')}ppob/payment';
    body = payment.toPayPPOB();
  }else if(payment.slug == 'simla'){
    url = '${GlobalConfiguration().getString('api_base_url')}payment';
    body = payment.toMap();
  }else{
    url = '${GlobalConfiguration().getString('api_base_url')}payment';
    body = payment.toMap();
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
    },
    body: json.encode(body),
  );
  if (response.statusCode == 200) {
    current_topup.value = Payment.fromJSON(json.decode(response.body)['data']);
    return current_topup.value;
  } else {
   
    throw new Exception(response.body);
  }
}


Future<Map> confirm(String id) async {
  User _user = userRepo.currentUser.value;

  Map data = { "id" : id };

  final String url = '${GlobalConfiguration().getString('api_base_url')}payment/confirm';
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
  if (response.statusCode == 200) {
    Map value = {
      'id' : json.decode(response.body)['transaksi_id'].toString(),
      'slug' : json.decode(response.body)['slug'].toString(),
    };
    return value;
  } else {
    throw new Exception(response.body);
  }
}

Future<Stream<Payment>> getPaymentDetail(String id) async {
  User _user = userRepo.currentUser.value;
  Uri uri = Helper.getUri('api/payment/detail/$id');
  final String _apiToken = 'Bearer ${_user.apiToken}';
  try {
    final client = new http.Client();
    final request = http.Request('get', uri);
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
  print(uri);
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) {
    return Payment.fromJSON(data);
  });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Payment.fromJSON({}));
  }
}
