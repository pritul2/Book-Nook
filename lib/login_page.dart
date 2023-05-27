// ignore_for_file: prefer_const_constructors

import 'package:book_nook/admin_homepage.dart';
import 'package:book_nook/homepage.dart';
import 'package:book_nook/vendor_homepage.dart';
import 'package:flutter/material.dart';
import 'package:book_nook/api_helpers/login_func.dart';
import 'widgets/cart.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _wrongCreds = false;
  int selectedRadio = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 150.0,
                    height: 150.0,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Book Nook',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RadioButtons(),
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            Visibility(
                              visible: _wrongCreds,
                              child: Text(
                                "Incorrect credentials",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            ElevatedButton(
                              child: Text('Login'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedRadio == 0) {
                                    // validate customer login
                                    // Validate from Login API
                                    var response = await login(
                                        _usernameController.text.toString(),
                                        _passwordController.text.toString(),
                                        "customer");

                                    if (response["Message"] ==
                                        "Login successful") {
                                      setState(() {
                                        _wrongCreds = false;
                                      });
                                      Cart cart = Cart();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage(cart: cart)));
                                    } else {
                                      setState(() {
                                        _wrongCreds = true;
                                      });
                                    }
                                  } else if (selectedRadio == 1) {
                                    var response = await login(
                                        _usernameController.text.toString(),
                                        _passwordController.text.toString(),
                                        "vendor");
                                    print("Respones");
                                    print(response["Message"]);

                                    if (response["Message"] ==
                                        "Login successful") {
                                      setState(() {
                                        _wrongCreds = false;
                                      });
                                      Cart cart = Cart();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VendorBooksPage()));
                                    } else {
                                      setState(() {
                                        _wrongCreds = true;
                                      });
                                    }
                                  } else if (selectedRadio == 2) {
                                    var response = await login(
                                        _usernameController.text.toString(),
                                        _passwordController.text.toString(),
                                        "admin");
                                    print("Respones");
                                    print(response["Message"]);

                                    if (response["Message"] ==
                                        "Login successful") {
                                      setState(() {
                                        _wrongCreds = false;
                                      });
                                      Cart cart = Cart();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminHomePage()));
                                    } else {
                                      setState(() {
                                        _wrongCreds = true;
                                      });
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 12.0),
                            TextButton(
                              child: Text('Don\'t have an account? Sign up'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RadioButtons() {
    return Row(
      children: [
        Radio(
          value: 0,
          groupValue: selectedRadio,
          onChanged: (value) {
            setState(() {
              selectedRadio = value!;
            });
          },
        ),
        Text('Customer'),
        Radio(
          value: 1,
          groupValue: selectedRadio,
          onChanged: (value) {
            setState(() {
              selectedRadio = value!;
            });
          },
        ),
        Text('Vendor'),
        Radio(
          value: 2,
          groupValue: selectedRadio,
          onChanged: (value) {
            setState(() {
              selectedRadio = value!;
            });
          },
        ),
        Text('Admin'),
      ],
    );
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: selectedRadio,
          activeColor: Colors.green,
          onChanged: (val) {
            print("Radio $val");
            setState(() {
              selectedRadio = val!;
            });
            ;
          },
        ),
        Radio(
          value: 2,
          groupValue: selectedRadio,
          activeColor: Colors.blue,
          onChanged: (val) {
            print("Radio $val");
            setState(() {
              selectedRadio = val!;
            });
            ;
          },
        ),
      ],
    );
  }
}
