import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';
import 'package:sparkathon_app/productCard.dart';
import 'package:sparkathon_app/productPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final Future<List<Dataset>> data;

  HomePage({Key? key, required this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Dataset> finalData = [];

  List<int> recommendedProductIndices = [];

  Future<void> fetchRecommendations(int product_index) async {
    
    final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/recommendations/${product_index}'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedProductIndices = List<int>.from(data['recommendations']);
        print(recommendedProductIndices);
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sustainix'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder<List<Dataset>>(
          future: widget.data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              List<Dataset> shuffledData = List.from(snapshot.data!)..shuffle();
              finalData = List.from(snapshot.data!);
              return dataList(shuffledData);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget dataList(List<Dataset> dataList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 2, // Spacing between columns
        mainAxisSpacing: 2, // Spacing between rows
      ),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () async {
              await fetchRecommendations(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                      data: dataList[index],
                      dataList: finalData,
                      recommend: recommendedProductIndices),
                ),
              );
            },
            child: buildProductCard(dataList, index));
      },
    );
  }
}
