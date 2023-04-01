import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all books
  Stream<List<Book>> getBooks() {
    return _db.collection('books').snapshots().map(
          (QuerySnapshot snapshot) => snapshot.docs
              .map((DocumentSnapshot doc) => Book.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> addBook(Book book) {
    return _db.collection('books').add(book.toMap());
  }

  Future<void> updateBook(Book book) {
    return _db.collection('books').doc(book.id).update(book.toMap());
  }

  // Delete a book
  Future<void> deleteBook(String id) {
    return _db.collection('books').doc(id).delete();
  }
}
