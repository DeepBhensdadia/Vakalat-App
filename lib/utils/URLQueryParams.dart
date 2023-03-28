class URLQueryParams {
  final Map<String, String> _values = {};

  // Appends a parameter to the query with received key.
  void append(String key, dynamic value) {
    _values[key] = Uri.encodeQueryComponent(value.toString());
  }

  // Removes a parameter from query by key.
  void remove(String key) {
    _values.remove(key);
  }

  // Convert to query string like the next example:
  // * param1=value1&param2=value2
  @override
  String toString() {
    String response = '';
    _values.forEach((key, value) {
      response += "$key=$value&";
    });
    return response.substring(
        0, response.isEmpty ? 0 : response.length - 1);
  }
}
