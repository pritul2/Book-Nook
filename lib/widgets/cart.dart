class Cart {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> book, String type) {
    book['type'] = type;
    print(book);
    _items.add(book);
  }

  void removeItem(Map<String, dynamic> book) {
    _items.remove(book);
  }

  void clear() {
    _items.clear();
  }

  int get itemCount => _items.length;

  double get totalPrice {
    return _items.fold(0, (total, book) => total + book['Price']);
  }
}
