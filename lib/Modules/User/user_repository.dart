import 'dart:convert';
import 'dart:io';

import 'package:bumaba/Modules/Simla/simla_model.dart';
import 'package:bumaba/Modules/Simla/simla_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'user_model.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
// ValueNotifier appaccess = new ValueNotifier(false);
// bool boolValue = prefs.getBool('boolValue');

Future<User> login(User user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}login';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    setCurrentUser(response.body);
    currentUser.value = User.fromErrorJSON(json.decode(response.body)['errors']);
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> setupPIN(String pin) async {
  final String _apiToken = 'Bearer ${currentUser.value.apiToken}';

  final String url = '${GlobalConfiguration().getString('api_base_url')}setup-pin';

  final client = new http.Client();
  final Map map = {
    'secure_code': pin,
  };

  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
    body: json.encode(map),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw new Exception(response.body);
  }
}

Future<bool> accessPIN(String pin) async {
  final String _apiToken = 'Bearer ${currentUser.value.apiToken}';

  final String url = '${GlobalConfiguration().getString('api_base_url')}access';
  final client = new http.Client();
  final Map map = {
    'secure_code': pin,
  };

  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
    body: json.encode(map),
  );
  if (response.statusCode == 200) {
    currentUser.value.appaccess = json.decode(response.body)['access'];
    return currentUser.value.appaccess;
  } else {
    throw new Exception(response.body);
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
  await prefs.remove('current_saldo');
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)['data']));
  }
}

Future<User> setAppAccess(status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
  // if (prefs.containsKey('current_user') && status) {
  currentUser.value.appaccess = status;
  // } else {
    // currentUser.value.securePin = false;
  // }
  // ignore: invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    // ignore: await_only_futures
    currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.value.appaccess = false;
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<User> update(User user) async {
  final String _apiToken = 'Bearer ${currentUser.value.apiToken}';

  final String url = '${GlobalConfiguration().getString('api_base_url')}userupdate/${currentUser.value.id}';

  final client = new http.Client();
  
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : _apiToken,
      },
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    return currentUser.value;
  } else {
    throw new Exception(response.body);
  }
}