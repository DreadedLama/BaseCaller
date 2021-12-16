import 'dart:io';

import 'package:http/http.dart' as http;

class MyHttpCalls {
  static Future<String> fetchDetails(String mobileNumber, String? token) async {
    final response = await http.get(
      Uri.parse(
          'https://webapi-noneu.truecaller.com/search?countryCode=in&q=$mobileNumber'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + token!,
      },
    );
    return response.body;
  }
}
