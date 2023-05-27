import 'package:flutter/material.dart';

import 'admin_vendor_check.dart';
import 'api_helpers/admin_get_orders.dart';
import 'login_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<dynamic> _orders = [];

  late TextEditingController _searchController;
  String _searchText = "";
  List orders = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _getOrders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> _getOrders({String username = ''}) async {
    Map<String, dynamic> response = await getOrders(username: username);
    List<dynamic> results = response["Results"];
    setState(() {
      _orders = results;
      orders = _orders;
    });
    print("ORDER HISTORY");
    print(_orders);
    return true;
  }

  List<Map<String, dynamic>> getFilteredOrders() {
    if (_searchText.isEmpty) {
      return _orders
          .expand((order) => order["items"])
          .map((item) => {
                "customer_id": item["customer_id"],
                "order_date": item["order_date"],
                "bookName": item["bookName"],
                "bookImageUrl": item["bookImageUrl"],
                "bookPrice": item["bookPrice"],
              })
          .toList();
    } else {
      final searchDate = DateTime.tryParse(_searchText);
      return _orders
          .where((order) =>
              order["customer_id"].contains(_searchText) ||
              (searchDate != null &&
                  order["order_date"].difference(searchDate).inDays == 0))
          .expand((order) => order["items"])
          .map((item) => {
                "customer_id": item["customer_id"],
                "order_date": item["order_date"],
                "bookName": item["bookName"],
                "bookImageUrl": item["bookImageUrl"],
                "bookPrice": item["bookPrice"],
              })
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Orders'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu_book_sharp)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AdminVendorCheck())));
              },
              icon: const Icon(Icons.business)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by customer ID',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onSubmitted: (query) {
                setState(() {
                  _searchText = query;
                  _getOrders(username: _searchText);
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DataTable(
                  headingTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  columns: [
                    DataColumn(label: Text('Customer ID')),
                    DataColumn(label: Text('Book Name')),
                    DataColumn(label: Text('Book Price')),
                    DataColumn(label: Text('Order Date')),
                  ],
                  rows: _buildTableRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    List<DataRow> rows = [];
    for (Map<String, dynamic> order in orders) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(
            order["customer_id"].toString(),
            style: TextStyle(
              fontSize: 14.0,
            ),
          )),
          DataCell(
            Row(
              children: [
                Image.network(
                  order["cover_image"],
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 8.0),
                Text(
                  order["title"].toString(),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          DataCell(Text(
            "\$${(order["invoice_amount"]).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14.0,
            ),
          )),
          DataCell(Text(
            order["date"].toString().split(" ").take(4).join(' '),
            style: TextStyle(
              fontSize: 14.0,
            ),
          )),
        ],
      ));
    }
    return rows;
  }
}
