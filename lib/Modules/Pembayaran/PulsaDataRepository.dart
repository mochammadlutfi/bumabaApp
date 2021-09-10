import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/Modules/Pembayaran/pulsa_data_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;


import '../User/user_model.dart';
import '../User/user_repository.dart' as userRepo;


Future<Stream<PulsaData>> getListPulsa(String type, String operator) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }

  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}ppob?type='+type +'&operator='+operator;
  print(url);

  final client = new http.Client();
  final request = http.Request('get', Uri.parse(url));
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return PulsaData.fromJSON(data);
  });
}
