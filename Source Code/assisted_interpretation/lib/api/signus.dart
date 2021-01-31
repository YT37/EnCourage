import 'package:http/http.dart' as http;

import './response.dart';

class SignUsApi {
  static Future<Response> getSigns(String sentence) async {
    Response response = Response(response: {"url": ""}, status: Status.Ok);

    try {
      print("Fetching Results...");

      http.Response token = await http
          .get(
              "https://api.txttosl.com/api/v1/translate?hoster=self&lang=BSL&text=${sentence.toLowerCase().trim()}&redirect=false")
          .timeout(
            Duration(seconds: 10),
          );

      print("Fetched Results! Status Code: ${token.statusCode}");

      if (token.statusCode == 200)
        response.response = {"url": token.body};
      else
        response.status = Status.Error;

      return response;
    } catch (e) {
      response.status = Status.Error;
      return response;
    }
  }
}
