// ignore_for_file: prefer_const_constructors
import 'package:book_nook/confirmation.dart';
import 'package:flutter/material.dart';

import 'api_helpers/create_order.dart';
import 'api_helpers/get_cart.dart';
import 'api_helpers/remove_from_cart.dart';
import 'widgets/cart.dart';
import 'widgets/book.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<dynamic> cart = [];

  @override
  void initState() {
    super.initState();
    _getCart();
  }

  Future<void> _getCart() async {
    var response = await getCart(1);
    cart = response['Results'];
    print("cart");
    print(response);
    setState(() {});
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
          title: Text('Checkout'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> book = cart[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Image.network(
                              book['cover_image'],
                              height: 50.0,
                              width: 50.0,
                            ),
                            title: Text(book['title']),
                            subtitle:
                                Text('\$${book['amount'].toStringAsFixed(2)}'),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                removeCart('1', book["ISBN"], book["for_rent"],
                                    book["for_sale"]);
                                cart.removeAt(index);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: Text(
                'Total:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              trailing: Text(
                '\$${cart.fold(0.0, (total, book) => total + book['amount']).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: Add code to push orders to db
                  await createOrder('1');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationPage(
                        books: cart,
                        totalPrice: cart
                            .fold(0.0, (total, book) => total + book['amount'])
                            .toStringAsFixed(2),
                      ),
                    ),
                    (route) => route.isFirst,
                  );
                },
                child: Text('Complete Purchase'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
