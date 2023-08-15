import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<int> recommendedProductIndices = [];
  int product_index = 0;

  Future<void> fetchRecommendations() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/recommendations/${product_index}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedProductIndices = List<int>.from(data['recommendations']);
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    // Use the recommendedProductIndices to display recommended products
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Products'),
      ),
      body: ListView.builder(
        itemCount: recommendedProductIndices.length,
        itemBuilder: (context, index) {
          final recommendedIndex = recommendedProductIndices[index];
          return ListTile(
            title: Text('Recommended Product ${recommendedIndex + 1}'),
            // Customize the UI as needed
          );
        },
      ),
    );
  }
}