import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/models/ppob_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;


import '../models/user_model.dart';
import 'user_repository.dart' as userRepo;


Future<Stream<PPOB>> getListPulsa(String type, String operator) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}ppob?type='+type +'&operator='+operator;
  // print(url);
  try {
    final client = new http.Client();
    final request = http.Request('get', Uri.parse(url));
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
    final streamedRest = await client.send(request);
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return PPOB.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new PPOB.fromJSON({}));
  }
}

Future<PLN> getPLNID(String subscriberId) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}ppob/cek-pln';
  final client = new http.Client();
  final Map map = {
    'phone': subscriberId,
  };
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
    body: json.encode(map),
  );
  PLN data = new PLN();
  if (response.statusCode == 200) {
    data = PLN.fromJSON(json.decode(response.body)['data']);
    return data;
  } else {
    throw new Exception(json.decode(response.body)['message']);
  }
}


