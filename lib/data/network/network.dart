import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_player/utils/utils.dart';

import '../exception.dart';

Future<dynamic> getRequest(String url) async {
  dynamic response;
  try {
    final res =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    response = await getResponseData(res);
    return response;
  } on SocketException {
    throw FetchDataException("No internet connection");
  } catch (e) {
    Utils.printMessage("Exception:${e.toString()}");
    throw FetchDataException("Connection time out");
  }
}

Future<dynamic> getResponseData(http.Response res) async {
  switch (res.statusCode) {
    case 200:
      final data = await jsonDecode(res.body);

      return data;
    case 404:
      throw BadRequestException("Page not found");
    case 501:
      throw InternalServerError("Something went wrong on the server");
  }
}
