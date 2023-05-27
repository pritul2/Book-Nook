
class Book {
  final String title;
  final String imageUrl;
  final double price;
  final String genre;
  final String author;
  final double rating;
  final String description;
  String? type;

  Book(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.genre,
      required this.author,
      required this.rating,
      required this.description});
}
