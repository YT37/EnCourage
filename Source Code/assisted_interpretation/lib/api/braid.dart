import 'dart:convert';

import 'package:http/http.dart' as http;

enum Status { Ok, Error }

class Response {
  Map _response;
  Status _status;

  Map get response => _response;
  Status get status => _status;

  set response(Map newResponse) {
    this._response = newResponse;
  }

  set status(Status newStatus) {
    this._status = newStatus;
  }

  Response({Map response, Status status}) {
    this._response = response;
    this._status = status;
  }
}

class BrAidApi {
  static Future<Response> getCells(String sentence) async {
    print("Fetching Results...");

    http.Response token = await http.post(
      "https://assisted-interpretation.herokuapp.com/generate_braille",
      // "https://assisted-interpretation.herokuapp.com/braid/cells",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, dynamic>{"sentence": sentence.toLowerCase().trim()},
      ),
    );

    print("Fetched Results! Status Code: ${token.statusCode}");

    Response response = Response(response: {
      "cells": [],
    }, status: Status.Ok);

    if (token.statusCode == 200)
      response.response = {
        "cells": jsonDecode(token.body)["response"]
      }; //TODO: Change response key to cells in server
    else
      response.status = Status.Error;

    return response;
  }

  static Future<Response> getCellsWithRepr(String sentence) async {
    http.Response token = await http.post(
      "https://assisted-interpretation.herokuapp.com/braid/cells-repr",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(
        <String, dynamic>{"sentence": sentence.toLowerCase().trim()},
      ),
    );

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
