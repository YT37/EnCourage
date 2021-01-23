import 'package:http/http.dart' as http;

enum Status { Ok, Error }

class Response {
  String _url;
  Status _status;

  String get url => _url;
  Status get status => _status;

  set url(String newUrl) {
    this._url = newUrl;
  }

  set status(Status newStatus) {
    this._status = newStatus;
  }

  Response({String url, Status status}) {
    this._url = url;
    this._status = status;
  }
}

class SignUsApi {
  static Future<Response> getSigns(String sentence) async {
    print("Fetching Results...");

    http.Response token = await http.get(
        "https://api.txttosl.com/api/v1/translate?hoster=self&lang=ASL&text=${sentence.toLowerCase().trim()}&redirect=false");

    print("Fetched Results! Status Code: ${token.statusCode}");

    Response response = Response(url: "", status: Status.Ok);

    if (token.statusCode == 200)
      response.url = token.body;
    else
      response.status = Status.Error;

    return response;
  }
}
