import 'package:http/http.dart' as http;
import 'dart:convert';

AddToCart(
    String user_id, String isbn, int qty, bool for_rent, bool for_sale) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body = jsonEncode(
        {"isbn": isbn, "for_rent": for_rent, "for_sale": for_sale, "qty": qty});
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/customer/add_to_cart/$user_id");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Add to Cart Successful');
    } else {
      print('Add to Cart Failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
  }
}
