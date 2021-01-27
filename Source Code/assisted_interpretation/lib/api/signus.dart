import 'package:http/http.dart' as http;

import 'response.dart';

class SignUsApi {
  static Future<Response> getSigns(String sentence) async {
    print("Fetching Results...");

    http.Response token = await http.get(
        "https://api.txttosl.com/api/v1/translate?hoster=self&lang=ASL&text=${sentence.toLowerCase().trim()}&redirect=false");

    print("Fetched Results! Status Code: ${token.statusCode}");

    Response response = Response(response: {"url": ""}, status: Status.Ok);

    if (token.statusCode == 200)
      response.response = {"url": token.body};
    else
      response.status = Status.Error;

    return response;
  }
}
