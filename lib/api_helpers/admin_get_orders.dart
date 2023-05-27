import 'package:http/http.dart' as http;
import 'dart:convert';

getOrders({String username = '', date = ''}) async {
  final headers = {"Content-type": "application/json"};
  try {
    final json_body = jsonEncode({"customer_username": username, "date": date});
    final api_url = Uri.parse("http://127.0.0.1:5000/api/view/orders/rent");
    print(json_body);
    http.Response response =
        await http.post(api_url, body: json_body, headers: headers);
    print(response);
    Map<String, dynamic> data = {};
    if (response.statusCode == 200) {
      print('Rent Orders Retrieval Successful');
      data = jsonDecode(response.body.toString());
    } else {
      print('Rent Orders Retrieval Failed');
    }

    final api_url2 = Uri.parse("http://127.0.0.1:5000/api/view/orders/sale");
    print(json_body);
    http.Response response2 =
        await http.post(api_url2, body: json_body, headers: headers);
    print(response2);
    if (response2.statusCode == 200) {
      print('Sale Orders Retrieval Successful');
      data.addAll(jsonDecode(response2.body.toString()));
    } else {
      print('Sale Orders Retrieval Failed');
      return data;
    }
    print('prior data');
    print(data);

    print('post data');
    print(data);
    return data;
  } catch (e) {
    print(e.toString());
  }
}
