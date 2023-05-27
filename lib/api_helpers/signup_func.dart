import 'package:http/http.dart' as http;
import 'dart:convert';

signup(Map givenData, String type) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body = jsonEncode(givenData);
    final api_url = Uri.parse("http://127.0.0.1:5000/api/${type}/signup");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Signup successful');
    } else {
      print('Signup failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
  }
}
