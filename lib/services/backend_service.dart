import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

class BackendServices {
  String domain = "https://stripe-init.herokuapp.com";

  Future<String?> getAccessToken(int amount) async {
    try {
      Map<String, String> header = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {"amount": amount};
      final url = Uri.parse("$domain/stripe-init");
      var response =
          await http.post(url, headers: header, body: convert.jsonEncode(body));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["data"]['paymentIntent'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
