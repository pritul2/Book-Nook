// username, password, email, phone, name
// ignore_for_file: prefer_const_constructors

import 'package:book_nook/api_helpers/cust_info_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_helpers/purchase_history.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  List<List<Map<String, dynamic>>> _orderHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCustInfo();
    _getOrderHistory();
  }

  void _showEditDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Profile'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final url =
                      Uri.parse('http://127.0.0.1:5000/api/customer/update/1');
                  final headers = {"Content-type": "application/json"};
                  final response = await http.post(url,
                      body: json.encode({
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "phone": _phoneController.text
                      }),
                      headers: headers);
                  // Handle response here
                  if (response.statusCode == 200) {
                    print('Update SUCCESSFUL');
                  } else {
                    print("Update UNSUCCESSFUL");
                  }
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        });
  }

  Future<bool> _getOrderHistory() async {
    Map<String, dynamic> response = await purchaseHistory(1);
    print("ORDERS");
    List<dynamic> results = response["Results"];
    print('HISTORYYYY');
    print(results);
    setState(() {
      _orderHistory = groupByDate(results);
    });
    print("ORDER HISTORY");
    print(_orderHistory);
    return true;
  }

  List<List<Map<String, dynamic>>> groupByDate(List<dynamic> results) {
    Map<String, List<Map<String, dynamic>>> groups = {};

    for (final result in results) {
      final dateStr = result['date'];
      if (!groups.containsKey(dateStr)) {
        groups[dateStr] = [];
      }
      groups[dateStr]!.add(result);
    }

    return groups.values.toList();
  }

  void _getCustInfo() async {
    var response = await viewCustomerProfile(1);
    var info = response['Results'];
    setState(() {
      _nameController.text = info[0]['Name'];
      _phoneController.text = info[0]['phone'];
      _emailController.text = info[0]['email'];
    });
    print("CUSTOMER");
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'User Info',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${_nameController.text}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Email: ${_emailController.text}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Phone: ${_phoneController.text}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: _showEditDialog,
                              child: Text('Edit Profile'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ]),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _orderHistory.length,
                  itemBuilder: (context, index) {
                    final orders = _orderHistory[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Date: ${(orders[0]["date"] as String).split(' ').take(4).join(' ')}',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    order["cover_image"].toString(),
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order["title"].toString(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Text(
                                        'Price: \$${order["price"]}',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
