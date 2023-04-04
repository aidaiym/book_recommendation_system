import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;
  String title;
  String author;
  String publisher;
  String description;
  String imageUrl;
  String genre;
  String category;
  int pageCount;
  int publishedYear;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.description,
    required this.imageUrl,
    required this.genre,
    required this.category,
    required this.pageCount,
    required this.publishedYear,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'],
      author: data['author'],
      publisher: data['publisher'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      genre: data['genre'],
      pageCount: data['pageCount'],
      publishedYear: data['publishedYear'],
      category: data['category'],
    );
  }
 
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'publisher': publisher,
      'description': description,
      'imageUrl': imageUrl,
      'genre': genre,
      'category': category,
      'pageCount': pageCount,
      'publishedYear': publishedYear,
    };
  }
}
