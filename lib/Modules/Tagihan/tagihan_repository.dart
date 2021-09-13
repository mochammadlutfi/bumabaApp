import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../../Core/helper.dart';

import '../../models/user_model.dart';
import '../../repository/user_repository.dart' as userRepo;
import 'tagihan_model.dart';

Future<Stream<Tagihan>> listTagihanSimpanan() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'Bearer ${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}tagihan/simpanan';

  final client = new http.Client();
  final request = http.Request('get', Uri.parse(url));
  request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
  });
  final streamedRest = await client.send(request);
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Tagihan.fromJSON(data);
  });
}
