import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class MyHttpCalls {
  static Future<String> fetchDetails() async {
    final response = await http.get(
      Uri.parse('https://webapi-noneu.truecaller.com/search?countryCode=in&q='+mobNumber),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader:
        'Bearer '+token,
      },
    );
    // print('response = ' + response.body);
    // final responseJson = jsonDecode(response.body);
    return response.body;
  }
}
