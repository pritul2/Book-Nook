import 'package:http/http.dart' as http;
import 'dart:convert';

login(String username, String password, String type) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body = jsonEncode({"username": username, "password": password});
    final api_url = Uri.parse("http://127.0.0.1:5000/api/${type}/login");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Login successful');
    } else {
      print('Login failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
  }
}
