// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getCart(user_id) async {
  final headers = {"Content-type": "application/json"};
  try {
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/customer/view_cart/$user_id");
    http.Response response = await http.get(api_url, headers: headers);
    if (response.statusCode == 200) {
      // print('Cart retrieved successfully');
    } else {
      // print('Cart retrieval fail');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
    return {};
  }
}
