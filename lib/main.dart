import 'package:book_nook/vendor_homepage.dart';
import 'package:flutter/material.dart';
import 'Profile.dart';
import 'admin_homepage.dart';
import 'widgets/cart.dart';
import 'homepage.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Book Nook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: VendorBooksPage());
    // home: AdminHomePage());
    // home: HomePage(cart: Cart()));
    // home: Profile());
    // home: LoginPage());
  }
}
