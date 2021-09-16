import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Core/custom_trace.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/models/slide_model.dart';
import 'package:bumaba/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'user_repository.dart' as userRepo;


Future<Stream<Slide>> getSlides() async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'Bearer ${_user.apiToken}';
  Uri uri = Helper.getUri('api/slider');
  try {
    final client = new http.Client();
    final request = http.Request('get', uri);
    request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : _apiToken,
    });
    final streamedRest = await client.send(request);

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Slide.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Slide.fromJSON({}));
  }
}
