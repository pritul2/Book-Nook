import 'package:book_nook/vendor_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_helpers/get_vendor_books.dart';

class VendorOrders extends StatefulWidget {
  const VendorOrders({Key? key}) : super(key: key);

  @override
  _VendorOrdersPageState createState() => _VendorOrdersPageState();
}

class _VendorOrdersPageState extends State<VendorOrders> {
  List<dynamic> _books = [];

  @override
  void initState() {
    super.initState();
    _getVendorBooks('42');
  }

  Future<void> _getVendorBooks(String vendor_id) async {
    Map<String, dynamic> response = await getVendorBooks(vendor_id);
    setState(() {
      _books = response["Results"];
    });
    print(_books);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Orders'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => VendorBooksPage())));
                },
                icon: const Icon(Icons.menu_book)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopify_sharp))
          ],
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Dismissible(
                  key: ValueKey(book['title']),
                  onDismissed: (direction) async {
                    print("ISBNN");
                    print(book["ISBN"]);
                    final url = Uri.parse(
                        'http://127.0.0.1:5000/api/vendor/remove_a_book/42');
                    final headers = {"Content-type": "application/json"};
                    final response = await http.post(url,
                        body: json.encode({"isbn": book["ISBN"]}),
                        headers: headers);
                    // Handle response here
                    if (response.statusCode == 200) {
                      print('REMOVING SUCCESSFUL');
                      setState(() {
                        _books.removeAt(index);
                      });
                    } else {
                      print("REMOVING UNSUCCESSFUL");
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 36,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(book['title']),
                      subtitle: Text(book['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${(book['price']).toStringAsFixed(2)}'),
                          SizedBox(width: 10),
                          Text('Stock: ${book['avail_qty']}'),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
