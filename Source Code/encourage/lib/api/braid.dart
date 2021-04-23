import 'dart:convert';

import 'package:http/http.dart' as http;

import "response.dart";

class BrAidApi {
  static Future<Response> getCells(String sentence) async {
    Response response = Response(response: {
      "cells": [],
    }, status: Status.Ok);

    try {
      http.Response token = await http.post(
        Uri.https(
          "encourage-server.herokuapp.com/braid",
          "/cells",
          {"sentence": sentence.trim()},
        ),
      );

      if (token.statusCode == 200)
        response.response = {"cells": jsonDecode(token.body)["cells"]};
      else
        response.status = Status.Error;

      return response;
    } catch (e) {
      response.status = Status.Error;
      return response;
    }
  }

  static Future<Response> getCellsWithRepr(String sentence) async {
    Response response = Response(
      response: {
        "cells": [],
        "repr": [],
      },
      status: Status.Ok,
    );

    try {
      http.Response token = await http.post(
        Uri.https(
          "encourage-server.herokuapp.com/braid",
          "/cells-repr",
          {"sentence": sentence.trim()},
        ),
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
    } catch (e) {
      response.status = Status.Error;
      return response;
    }
  }
}
