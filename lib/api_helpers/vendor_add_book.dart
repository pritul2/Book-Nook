import 'package:http/http.dart' as http;
import 'dart:convert';

addBook(
    user_id,
    isbn,
    title,
    price,
    cover_image,
    page_count,
    description,
    publisher,
    published_date,
    authors,
    is_salebook,
    is_rentbook,
    is_fiction,
    is_children,
    is_academics) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body = jsonEncode({"address_id": 1});
    final api_url =
        Uri.parse("http://127.0.0.1:5000/api/customer/place_an_order/$user_id");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    if (response.statusCode == 200) {
      print('Create Order Successful');
    } else {
      print('Create Order Failed');
    }
    Map<String, dynamic> data = jsonDecode(response.body.toString());
    return data;
  } catch (e) {
    print(e.toString());
  }
}
