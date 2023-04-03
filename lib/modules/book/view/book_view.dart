import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  static const String id = 'book_screen';

  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final book = streamSnapshot.data!.docs[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AspectRatio(
                      //   aspectRatio: 1.5,
                      //   child: Image.network(book['coverImageUrl']),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(book['title']),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
