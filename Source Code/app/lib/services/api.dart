// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:http/http.dart' as http;

import '/config/constants.dart';
import '/models/response.dart';

class API {
  static Future<Response> translate(String text) async {
    Map<String, dynamic> response;
    Status status;

    try {
      final http.Response token = await http.post(
        Uri.https(
          SERVER,
          TO.value == TO_LANGS[0] ? "/braille" : "/sign",
          {"text": text.trim()},
        ),
      );

      if (token.statusCode == 200) {
        final Map<dynamic, dynamic> data = jsonDecode(token.body);

        response = {
          "output": data["output"],
          "captions": data["captions"],
        };
        status = Status.OK;
      } else {
        response = {};
        status = Status.ERROR;
      }
    } catch (e) {
      response = {};
      status = Status.ERROR;
    }

    return Response(
      response: response,
      status: status,
    );
  }
}
