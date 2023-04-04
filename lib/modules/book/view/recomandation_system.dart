import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<String> _recommendedBooks = [];

  @override
  void initState() {
    super.initState();
    _getRecommendations();
  }

  Future<void> _getRecommendations() async {
    String userId = 'user1';
    Map<String, double> userRatings = {};
    QuerySnapshot ratingSnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .where('userId', isEqualTo: userId)
        .get();
    for (var doc in ratingSnapshot.docs) {
      userRatings[doc['bookId']] = doc['rating'];
    }

    Map<String, Map<String, dynamic>> bookData = {};
    QuerySnapshot bookSnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    for (var doc in bookSnapshot.docs) {
      bookData[doc.id] = doc.data();
    }

    // Calculate similarities
    Map<String, double> similarities = {};
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .where('bookId', whereIn: userRatings.keys.toList())
        .get();
    userSnapshot.docs.forEach((doc) async {
      if (doc['userId'] != userId) {
        Map<String, double> otherRatings = {};
        QuerySnapshot otherSnapshot = await FirebaseFirestore.instance
            .collection('ratings')
            .where('userId', isEqualTo: doc['userId'])
            .where('bookId', whereIn: userRatings.keys.toList())
            .get();
        for (var otherDoc in otherSnapshot.docs) {
          otherRatings[otherDoc['bookId']] = otherDoc['rating'];
        }
        double similarity = _cosineSimilarity(userRatings, otherRatings);
        similarities[doc['userId']] = similarity;
      }
    });

    // Get recommended books
    Map<String, double> predictedRatings = {};
    bookData.forEach((bookId, book) {
      if (!userRatings.containsKey(bookId)) {
        double numerator = 0;
        double denominator = 0;
        similarities.forEach((otherUserId, similarity) {
          if (otherRatings.containsKey(bookId)) {
            numerator += similarity * otherRatings[bookId];
            denominator += similarity;
          }
        });
        double predictedRating = numerator / denominator;
        predictedRatings[bookId] = predictedRating;
      }
    });

    List<String> sortedBooks = predictedRatings.keys.toList()
      ..sort((a, b) => predictedRatings[b]!.compareTo(predictedRatings[a]!));
    _recommendedBooks = sortedBooks.take(5).toList();

    setState(() {});
  }

  double _cosineSimilarity(
      Map<String, double> vector1, Map<String, double> vector2) {
    double dotProduct = 0;
    double norm1 = 0;
    double norm2 = 0;
    vector1.forEach((key, value) {
      if (vector2.containsKey(key)) {
        dotProduct += value * vector2[key]!;
      }
      norm1 += value * value;
    });
    vector2.forEach((key, value) {
      norm2 += value * value;
    });
    return dotProduct / (sqrt(norm1) * sqrt(norm2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Books'),
      ),
      body: ListView.builder(
        itemCount: _recommendedBooks.length,
        itemBuilder: (context, index) {
          String bookId = _recommendedBooks[index];
          return ListTile(
            title: Text(bookData[bookId]['title']),
            subtitle: Text(bookData[bookId]['author']),
            leading: Image.network(bookData[bookId]['imageUrl']),
          );
        },
      ),
    );
  }
}
