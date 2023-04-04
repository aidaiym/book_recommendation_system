import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/book_model.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late List<Book> _books;
  late List<Book> _filteredBooks;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    setState(() {
      _books = querySnapshot.docs
          .map((doc) =>
              Book.fromFirestore(doc.data() as DocumentSnapshot<Object?>))
          .toList();
      _filteredBooks = _books;
    });
  }

  void _filterBooks(String? category) {
    setState(() {
      _filteredBooks =
          _books.where((book) => book.category == category).toList();
    });
  }

  void _searchBooks(String query) {
    setState(() {
      _filteredBooks = _books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search books...',
              ),
              onChanged: _searchBooks,
            ),
          ),
          DropdownButton(
            value: 'All',
            items: const [
              DropdownMenuItem(value: 'All', child: Text('All')),
              DropdownMenuItem(
                  value: 'Science Fiction', child: Text('Science Fiction')),
              DropdownMenuItem(value: 'Mystery', child: Text('Mystery')),
              DropdownMenuItem(value: 'Romance', child: Text('Romance')),
            ],
            onChanged: _filterBooks,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Text(book.category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
