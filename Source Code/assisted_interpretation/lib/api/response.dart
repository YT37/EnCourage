class Response {
  Map _response;
  Status _status;

  Map get response => _response;
  set response(Map newResponse) {
    this._response = newResponse;
  }

  Status get status => _status;
  set status(Status newStatus) {
    this._status = newStatus;
  }

  Response({Map response, Status status}) {
    this._response = response;
    this._status = status;
  }
}

enum Status { Ok, Error }
