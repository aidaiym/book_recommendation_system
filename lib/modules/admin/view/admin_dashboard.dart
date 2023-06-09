import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../files.dart';
import '../logic/admin_cubit.dart';

class AdminDash extends StatelessWidget {
  static const String id = 'admin_dash';

  final firestoreService = FirestoreService();

  AdminDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookshelf'),
      ),
      body: BlocProvider(
        create: (context) => AdminCubit(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListTile(
                      title: Text(streamSnapshot.data!.docs[index]['title']),
                      subtitle:
                          Text(streamSnapshot.data!.docs[index]['author']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // FirestoreService().deleteBook(id)
                            },
                          ),
                        ],
                      ),
                      selected: true,
                      selectedTileColor: Colors.grey[300],
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         BookDetailsScreen(bookId: '$index'),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddBookScreen.id);
        },
      ),
    );
  }
}
