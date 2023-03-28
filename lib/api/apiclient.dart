import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// String baseUrl = "http://192.168.1.11:8005/Api";

String baseUrl = "https://www.vakalat.com/user_api";

String apiKey = "5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n";
String device = "2";

//Time Out Refer from https://stackoverflow.com/questions/51487818/set-timeout-for-httpclient-get-request
Future getRequest(String url) async {
  return http.get(Uri.parse(url)).timeout(const Duration(seconds: 30), onTimeout: () {
    return null!;
  }).then((http.Response response) {
    return json.decode(response.body);
  });
}
