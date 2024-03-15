class ApiHeader {
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    return header;
  }
}
