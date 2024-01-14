class Response {
  final Map<String, dynamic> response;
  final Status status;

  Response({
    required this.response,
    required this.status,
  });
}

enum Status { OK, ERROR, EMPTY }
