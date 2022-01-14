class DefaultResponseEntity {
  int statusCode;
  Map<String, String> headers;
  Map<String, dynamic> body;

  DefaultResponseEntity({
    this.statusCode,
    this.headers,
    this.body,
  });
}
