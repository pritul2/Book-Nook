import 'package:book_nook/admin_homepage.dart';
import 'package:book_nook/homepage.dart';
import 'package:book_nook/vendor_homepage.dart';
import 'package:book_nook/widgets/cart.dart';
import 'package:flutter/material.dart';

import 'api_helpers/login_func.dart';
import 'api_helpers/signup_func.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankNumberController = TextEditingController();

  int selected_radio = 0;
  bool _wrongCreds = false;

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
                      child: Column(
                        children: [
                          RadioButtons(),
                          Form(
                            key: _formKey,
                            child: selected_radio == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your email address';
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
                                            return 'Please enter a password';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          labelText: 'Enter Username',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a username';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          labelText: 'Enter phone number',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Enter Full Name',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your full name';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _bankNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Enter bank name',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a bank name';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _bankNumberController,
                                        decoration: InputDecoration(
                                          labelText:
                                              'Enter bank account number',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter bank account number';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 24.0),
                                      ElevatedButton(
                                        child: Text('Sign Up'),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // TODO: Implement sign up logic
                                            // You can access the email and password
                                            // from the _emailController and
                                            // _passwordController respectively
                                            var response = await signup({
                                              'username':
                                                  _usernameController.text,
                                              'password':
                                                  _passwordController.text,
                                              'email': _emailController.text,
                                              'phone': _phoneController.text,
                                              'name': _nameController.text,
                                              'bank': _bankNameController.text,
                                              'account':
                                                  _bankNumberController.text
                                            }, "customer");
                                            print("Respones");
                                            print(response["Message"]);

                                            if (response["Message"] ==
                                                "Successfully registered.") {
                                              setState(() {
                                                _wrongCreds = false;
                                              });
                                              Cart cart = Cart();
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              cart: Cart())));
                                            } else {
                                              setState(() {
                                                _wrongCreds = true;
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                : selected_radio == 1
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextFormField(
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your email address';
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
                                                return 'Please enter a password';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _usernameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter Username',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a username';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _phoneController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter phone number',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a phone number';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter Full Name',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your full name';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _bankNameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter city',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a city';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _bankNumberController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter company',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter company you represent';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 24.0),
                                          ElevatedButton(
                                            child: Text('Sign Up'),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // TODO: Implement sign up logic
                                                // You can access the email and password
                                                // from the _emailController and
                                                // _passwordController respectively
                                                var response = await signup({
                                                  'username':
                                                      _usernameController.text,
                                                  'password':
                                                      _passwordController.text,
                                                  'email':
                                                      _emailController.text,
                                                  'phone':
                                                      _phoneController.text,
                                                  'name': _nameController.text,
                                                  'city':
                                                      _bankNameController.text,
                                                  'company':
                                                      _bankNumberController.text
                                                }, "vendor");
                                                print("Respones");
                                                print(response["Message"]);

                                                if (response["Message"] ==
                                                    "Successfully registered.") {
                                                  setState(() {
                                                    _wrongCreds = false;
                                                  });
                                                  Cart cart = Cart();
                                                  // ignore: use_build_context_synchronously

                                                  // show the dialog
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Thanks for signing up"),
                                                        content: Text(
                                                            "Wait for approval"),
                                                        actions: [],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  setState(() {
                                                    _wrongCreds = true;
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextFormField(
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your email address';
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
                                                return 'Please enter a password';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _usernameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter Username',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a username';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _phoneController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter phone number',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a phone number';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter Full Name',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your full name';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 12.0),
                                          TextFormField(
                                            controller: _bankNameController,
                                            decoration: InputDecoration(
                                              labelText: 'Enter position',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter position';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 24.0),
                                          ElevatedButton(
                                            child: Text('Sign Up'),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // TODO: Implement sign up logic
                                                // You can access the email and password
                                                // from the _emailController and
                                                // _passwordController respectively
                                                var response = await signup({
                                                  'username':
                                                      _usernameController.text,
                                                  'password':
                                                      _passwordController.text,
                                                  'email':
                                                      _emailController.text,
                                                  'phone':
                                                      _phoneController.text,
                                                  'name': _nameController.text,
                                                  'position':
                                                      _bankNameController.text,
                                                }, "admin");
                                                print("Respones");
                                                print(response["Message"]);

                                                if (response["Message"] ==
                                                    "Successfully registered.") {
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
                                            },
                                          ),
                                        ],
                                      ),
                          ),
                          Visibility(
                            visible: _wrongCreds,
                            child: Text(
                              "Invalid information",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
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
          groupValue: selected_radio,
          onChanged: (value) {
            setState(() {
              selected_radio = value!;
            });
          },
        ),
        Text('Customer'),
        Radio(
          value: 1,
          groupValue: selected_radio,
          onChanged: (value) {
            setState(() {
              selected_radio = value!;
            });
          },
        ),
        Text('Vendor'),
        Radio(
          value: 2,
          groupValue: selected_radio,
          onChanged: (value) {
            setState(() {
              selected_radio = value!;
            });
          },
        ),
        Text('Admin'),
      ],
    );
  }
}
