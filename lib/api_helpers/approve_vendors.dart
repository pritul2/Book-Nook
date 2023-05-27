import 'package:http/http.dart' as http;
import 'dart:convert';

approveVendors(String user_id, String username, bool is_approve) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body =
        jsonEncode({"username": username, "is_approve": is_approve});
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/admin/approve_vendor/$user_id");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Vendor Modification Successful');
    } else {
      print('Vendor Modification Failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    print("Data");
    print(data);
    return data;
  } catch (e) {
    print(e.toString());
  }
}
