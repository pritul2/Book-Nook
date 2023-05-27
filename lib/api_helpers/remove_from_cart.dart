import 'package:http/http.dart' as http;
import 'dart:convert';

removeCart(String user_id, String isbn, int for_rent, int for_sale) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body =
        jsonEncode({"isbn": isbn, "for_rent": for_rent, "for_sale": for_sale});
    final api_url = Uri.parse(
        "http://127.0.0.1:5000/api/customer/remove_from_cart/$user_id");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Remove from cart successful');
    } else {
      print('Remove from cart failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
  }
}
