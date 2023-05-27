// ignore_for_file: prefer_const_constructors

import 'package:book_nook/Profile.dart';
import 'package:flutter/material.dart';

import 'api_helpers/allbooks.dart';
import 'api_helpers/filter_genre.dart';
import 'api_helpers/get_cart.dart';
import 'api_helpers/login_func.dart';
import 'login_page.dart';
import 'widgets/book.dart';
import 'widgets/cart.dart';
import 'checkout.dart';
import 'fullbook_page.dart';

class HomePage extends StatefulWidget {
  final Cart cart;
  const HomePage({Key? key, required this.cart}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> books = [];
  List<dynamic> filteredBooks = [];
  String selectedGenre = "All";
  late TextEditingController _searchController;
  late int _cartCount;
  late Cart _cart;

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
    _searchController = TextEditingController();
    _cartCount = widget.cart.itemCount;
    _cart = widget.cart;
    _getBookData();
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> _getBookData() async {
    Map<String, dynamic> response = await allbooks();
    setState(() {
      books = response["Results"];
      filteredBooks = books;
    });
    print("BOOKKK");
    print(books[0]);
    return true;
  }

  Future<void> _onGenreChanged() async {
    if (selectedGenre != 'All') {
      Map<String, dynamic> filterResponse = await filterGenre(selectedGenre);
      setState(() {
        print(selectedGenre);
        books = filterResponse['Results'];
        filteredBooks = books;
      });
    } else {
      Map<String, dynamic> response = await allbooks();
      setState(() {
        books = response["Results"];
        filteredBooks = books;
      });
    }
  }

  Future<void> _onSearch() async {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        filteredBooks = books.where((book) {
          final String text = _searchController.text.toLowerCase();
          final String bookTitle = book['Title'].toLowerCase();
          return bookTitle.contains(text);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Nook'),
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
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: Icon(Icons.account_circle_rounded)),
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for books',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) {
                          _onSearch();
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: selectedGenre,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGenre = value!;
                            _onGenreChanged();
                          });
                        },
                        underline: SizedBox.shrink(),
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width * 0.01,
                        ),
                        items: ["All", "Fiction", "Academics", "Children"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01,
                                  fontWeight: selectedGenre == value
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                GridView.extent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: 0.6,
                    padding: const EdgeInsets.all(30),
                    children: filteredBooks
                        .map((book) => GestureDetector(
                              onTap: () async {
                                print(book);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookInfoPage(book: book)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                book['Cover_image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book['Title'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            '\$${book['Price']}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
