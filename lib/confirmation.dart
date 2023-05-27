// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/book.dart';
import 'widgets/cart.dart';
import 'homepage.dart';

class ConfirmationPage extends StatefulWidget {
  final List<dynamic> books;
  final String totalPrice;

  ConfirmationPage({required this.books, required this.totalPrice});

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order placed',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.books
                  .map((book) => Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.43,
                            0.0,
                            0,
                            0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  book['cover_image'],
                                  height: 50.0,
                                  width: 50.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    '${book['title']} - \$${book['amount'].toStringAsFixed(2)}')
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Price: ${widget.totalPrice}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(cart: Cart())));
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
