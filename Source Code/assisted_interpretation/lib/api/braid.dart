import 'dart:convert';

import 'package:http/http.dart' as http;

import "response.dart";

class BrAidApi {
  static Future<Response> getCells(String sentence) async {
    print("Fetching Results...");

    http.Response token = await http.post(
      "https://assisted-interpretation.herokuapp.com/braid/cells",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, dynamic>{"sentence": sentence.trim()},
      ),
    );

    print("Fetched Results! Status Code: ${token.statusCode}");

    Response response = Response(response: {
      "cells": [],
    }, status: Status.Ok);

    if (token.statusCode == 200)
      response.response = {"cells": jsonDecode(token.body)["cells"]};
    else
      response.status = Status.Error;

    return response;
  }

  static Future<Response> getCellsWithRepr(String sentence) async {
    print("Fetching Results...");

    http.Response token = await http.post(
      "https://assisted-interpretation.herokuapp.com/braid/cells-repr",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, dynamic>{"sentence": sentence.trim()},
      ),
    );

    print("Fetched Results! Status Code: ${token.statusCode}");

    Response response = Response(
      response: {
        "cells": [],
        "repr": [],
      },
      status: Status.Ok,
    );

    if (token.statusCode == 200) {
      Map data = jsonDecode(token.body);
      response.response = {
        "cells": data["cells"],
        "repr": data["repr"],
      };
    } else
      response.status = Status.Error;

    return response;
  }
}
