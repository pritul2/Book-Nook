// ignore_for_file: prefer_const_constructors

import 'package:book_nook/api_helpers/add_to_cart.dart';
import 'package:book_nook/checkout.dart';
import 'package:flutter/material.dart';
import 'widgets/book.dart';
import 'widgets/cart.dart';

class BookInfoPage extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookInfoPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookInfoPageState createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
  bool _showError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.book['Title']
              // 'title'
              ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.book['Cover_image'],
                          height: 400.0,
                          width: 200.0,
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book['Title'],
                              // 'title',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              widget.book["Author"] == null
                                  ? ""
                                  : 'by ${(widget.book['Author'] as List<dynamic>).join(',')}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              widget.book['Description'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  widget.book['Avg_rating'] != null
                                      ? '${widget.book['Avg_rating'].toStringAsPrecision(2)}/5.0'
                                      : 'No ratings',
                                  // 'rating',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      var response = await AddToCart('1',
                                          widget.book['ISBN'], 1, false, true);
                                      if (response["Message"] ==
                                              "Error occurred in Add-to-cart" ||
                                          response["Message"] ==
                                              "Exceeds Available Quantity!") {
                                        setState(() {
                                          _showError = true;
                                        });
                                      } else {
                                        _showError = false;
                                      }
                                    },
                                    child: Text('Buy'),
                                  ),
                                  SizedBox(width: 12.0),
                                  ElevatedButton(
                                    onPressed: () async {
                                      var response = await AddToCart('1',
                                          widget.book['ISBN'], 1, true, false);
                                      if (response["Message"] ==
                                              "Error occurred in Add-to-cart" ||
                                          response["Message"] ==
                                              "Exceeds Available Quantity!") {
                                        setState(() {
                                          _showError = true;
                                        });
                                      } else {
                                        _showError = false;
                                      }
                                    },
                                    child: Text('Rent'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Visibility(
                              visible: _showError,
                              child: Text('Unable to add to cart'),
                            )
                          ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
