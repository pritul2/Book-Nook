// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> viewCustomerProfile(int user_id) async {
  final headers = {"Content-type": "application/json"};
  try {
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/customer/viewprofile/$user_id");
    http.Response response = await http.get(api_url, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Profile retrieved successfully');
    } else {
      print('Profile retrieval fail');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    print('DATAA');
    print(data);
    return data;
  } catch (e) {
    print(e.toString());
    return {};
  }
}
