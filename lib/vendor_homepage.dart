import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_nook/vendor_orders.dart';
import 'package:flutter/material.dart';

import 'api_helpers/allbooks.dart';
import 'login_page.dart';

class VendorBooksPage extends StatefulWidget {
  const VendorBooksPage({Key? key}) : super(key: key);

  @override
  _VendorBooksPageState createState() => _VendorBooksPageState();
}

class _VendorBooksPageState extends State<VendorBooksPage> {
  List<dynamic> _books = [];
  final _formKey = GlobalKey<FormState>();
  final _isbnController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _coverImageController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _publisherController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _authorsController = TextEditingController();
  final _fixedDiscountController = TextEditingController();
  final _availQtyController = TextEditingController();
  final _depositController = TextEditingController();
  final _qtyController = TextEditingController();
  final _rentalFeeController = TextEditingController();
  final _genreController = TextEditingController();
  final _introController = TextEditingController();
  final _ageGroupController = TextEditingController();
  final _mainCharacterController = TextEditingController();
  final _courseController = TextEditingController();
  final _levelController = TextEditingController();

  bool _isSaleBook = false;
  bool isAcademics = false;
  bool _isRentBook = false;
  bool isFiction = false;
  bool isChildrens = false;

  Future<void> _submitForm() async {
    final url = Uri.parse('http://127.0.0.1:5000/api/vendor/add_a_book/42');
    final headers = {"Content-type": "application/json"};
    var data = {
      "isbn": _isbnController.text,
      "title": _titleController.text,
      "price": _priceController.text,
      "cover_image": _coverImageController.text,
      "page_count": _pageCountController.text,
      "description": _descriptionController.text,
      "publisher": _publisherController.text,
      "published_date": _publishedDateController.text,
      "authors": _authorsController.text.split(','),
      "is_salebook": _isSaleBook,
      "fixed_discount": _fixedDiscountController.text.isEmpty
          ? ""
          : _fixedDiscountController.text,
      "avail_qty":
          _availQtyController.text.isEmpty ? "" : _availQtyController.text,
      "is_rentbook": _isRentBook,
      "deposit": _depositController.text.isEmpty ? "" : _depositController.text,
      "qty": _qtyController.text.isEmpty ? "" : _qtyController.text,
      "rental_fee":
          _rentalFeeController.text.isEmpty ? "" : _rentalFeeController.text,
      "is_fiction": isFiction,
      "genre": _genreController.text.isEmpty ? "" : _genreController.text,
      "intro": _introController.text.isEmpty ? "" : _introController.text,
      "is_children": isChildrens,
      "age_group":
          _ageGroupController.text.isEmpty ? "" : _ageGroupController.text,
      "main_character": _mainCharacterController.text.isEmpty
          ? ""
          : _mainCharacterController.text,
      "is_academics": isAcademics,
      "course": _courseController.text.isEmpty ? "" : _courseController.text,
      "level": _levelController.text.isEmpty ? "" : _levelController.text
    };
    print(data);
    final response =
        await http.post(url, body: json.encode(data), headers: headers);
    // Handle response here
    if (response.statusCode == 200) {
      print('ADDING SUCCESSFUL');
    } else {
      print("ADDING UNSUCCESSFUL");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Books'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu_book)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => VendorOrders())));
              },
              icon: const Icon(Icons.shopify_sharp)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'ISBN'),
                            controller: _isbnController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an ISBN.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Title'),
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a title.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Price'),
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a price.';
                              } else if (double.tryParse(value) == null) {
                                return 'Please enter a valid price.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Cover Image URL'),
                            controller: _coverImageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a cover image URL.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Page Count'),
                            controller: _pageCountController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a page count.';
                              } else if (int.tryParse(value) == null) {
                                return 'Please enter a valid page count.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Publisher'),
                            controller: _publisherController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a publisher.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Published Date'),
                            controller: _publishedDateController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a published date (YYYY-MM-DD).';
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Authors (comma-separated)'),
                            controller: _authorsController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter at least one author.';
                              }
                              return null;
                            },
                          ),
                          SwitchListTile(
                            title: Text("For Sale"),
                            value: _isSaleBook,
                            onChanged: (value) {
                              setState(() {
                                _isSaleBook = value;
                              });
                            },
                          ),
                          _isSaleBook
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Fixed Discount"),
                                      TextFormField(
                                        controller: _fixedDiscountController,
                                        decoration: InputDecoration(
                                          hintText: "2",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a discount';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Available Quantity"),
                                      TextFormField(
                                        controller: _availQtyController,
                                        decoration: InputDecoration(
                                          hintText: "5",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter quantity';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                )
                              : SizedBox(height: 0),
                          SwitchListTile(
                            title: Text("For Rent"),
                            value: _isRentBook,
                            onChanged: (value) {
                              setState(() {
                                _isRentBook = value;
                              });
                            },
                          ),
                          _isRentBook
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Deposit"),
                                      TextFormField(
                                        controller: _depositController,
                                        decoration: InputDecoration(
                                          hintText: "2",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a deposit';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Available Quantity"),
                                      TextFormField(
                                        controller: _availQtyController,
                                        decoration: InputDecoration(
                                          hintText: "5",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter quantity';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Rental Fee"),
                                      TextFormField(
                                        controller: _rentalFeeController,
                                        decoration: InputDecoration(
                                          hintText: "5",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter rental fee';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                )
                              : SizedBox(height: 0),
                          SwitchListTile(
                            title: Text("Academic?"),
                            value: isAcademics,
                            onChanged: (value) {
                              setState(() {
                                isAcademics = value;
                              });
                            },
                          ),
                          isAcademics
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Course"),
                                      TextFormField(
                                        controller: _courseController,
                                        decoration: InputDecoration(
                                          hintText: "Course",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the course';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Level"),
                                      TextFormField(
                                        controller: _levelController,
                                        decoration: InputDecoration(
                                          hintText: "Level",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the level';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                )
                              : SizedBox(height: 0),
                          SwitchListTile(
                            title: Text("Fiction?"),
                            value: isFiction,
                            onChanged: (value) {
                              setState(() {
                                isFiction = value;
                              });
                            },
                          ),
                          isFiction
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Genre"),
                                      TextFormField(
                                        controller: _genreController,
                                        decoration: InputDecoration(
                                          hintText: "Thriller",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the genre';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Intro"),
                                      TextFormField(
                                        controller: _introController,
                                        decoration: InputDecoration(
                                          hintText: "intro",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the intro';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                )
                              : SizedBox(height: 0),
                          SwitchListTile(
                            title: Text("Children?"),
                            value: isChildrens,
                            onChanged: (value) {
                              setState(() {
                                isChildrens = value;
                              });
                            },
                          ),
                          isChildrens
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Age_group"),
                                      TextFormField(
                                        controller: _ageGroupController,
                                        decoration: InputDecoration(
                                          hintText: "age group",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the age group';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                      Text("Main Character"),
                                      TextFormField(
                                        controller: _mainCharacterController,
                                        decoration: InputDecoration(
                                          hintText: "John",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the main character';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 16.0),
                                    ],
                                  ),
                                )
                              : SizedBox(height: 0),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO;
                                _submitForm();
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ]))),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
