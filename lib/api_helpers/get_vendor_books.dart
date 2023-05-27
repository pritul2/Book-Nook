import 'package:http/http.dart' as http;
import 'dart:convert';

getVendorBooks(String vendor_id) async {
  final headers = {"Content-type": "application/json"};
  try {
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/vendor/view/rentbooks/$vendor_id");
    http.Response response = await http.get(api_url, headers: headers);
    print(response);
    Map<String, dynamic> data = {};
    if (response.statusCode == 200) {
      print('Vendor Books Retrieval Successful');
      data = jsonDecode(response.body.toString());
    } else {
      print('Vendor Books Retrieval Failed');
    }

    final api_url2 =
        Uri.parse("http://127.0.0.1:5000/api/vendor/view/salebooks/$vendor_id");
    http.Response response2 = await http.get(api_url2, headers: headers);
    print(response2);
    if (response2.statusCode == 200) {
      print('Vendor Sale Books Retrieval Successful');
      data.addAll(jsonDecode(response2.body.toString()));
    } else {
      print('Vendor Sale Books Retrieval Failed');
      return data;
    }

    return data;
  } catch (e) {
    print(e.toString());
  }
}
