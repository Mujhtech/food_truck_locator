import 'dart:convert';

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

  Future<bool> sendNotification(String token, String title, String msg) async {
    Uri url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final data = {
      "notification": {"body": msg, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": token
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAlKFCxfs:APA91bEVUoT7PlGl-tJS23JIDGNTJetEdX93evQdsGL-4ZGVaoXlI0unEGx6p0viSrg3Bo7fyQHDvm3DyFuctlAG0wUoE7TkUw_0wytawYIMFqJTmAL47ThSAGFP0OnscAgsn5pXMAiy'
    };
    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print('exception $e');
      return false;
    }
  }
}
