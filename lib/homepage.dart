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

  @override
  void initState() {
    super.initState();
    recommendedProductIndices.addAll(recommendedProductIndices);
  }

  Future<void> fetchRecommendations(int product_index) async {
    final response = await http.get(
        Uri.parse('https://sustainable-recommender.vercel.app/recommendations/${product_index}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedProductIndices = List<int>.from(data['recommendations']);
        print(recommendedProductIndices);
      });
    } else {}
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double tileSpacing = 8.0; // Adjust the spacing between tiles
        double screenWidth = constraints.maxWidth;

        int crossAxisCount = (screenWidth ~/ 200.0)
            .clamp(1, 6); // Set the max to 6 tiles per row

        double tileWidth =
            (screenWidth - (tileSpacing * (crossAxisCount - 1))) /
                crossAxisCount;
        double tileHeight =
            tileWidth * 3; // Adjust the height based on your preference

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: tileSpacing,
            mainAxisSpacing: tileSpacing,
          ),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await fetchRecommendations(dataList[index].S_no);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      data: dataList[index],
                      dataList: finalData,
                      recommend: recommendedProductIndices,
                    ),
                  ),
                );
              },
              child: Container(
                width: tileWidth,
                height: tileHeight,
                child: buildProductCard(dataList, index),
              ),
            );
          },
        );
      },
    );
  }
}
