import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';
import 'package:sparkathon_app/productCard.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final Dataset data;
  final List<Dataset> dataList;
  final List<int> recommend;

  const ProductPage(
      {Key? key,
      required this.data,
      required this.dataList,
      required this.recommend})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<int> recommendedProductIndices = [];
  //List<Dataset> finalData = [];

  @override
  void initState() {
    super.initState();
    recommendedProductIndices.addAll(widget.recommend);
  }

  Future<void> fetchRecommendations(int product_index) async {
    final response = await http.get(Uri.parse(
        'https://sustainable-recommender.vercel.app/recommendations/${product_index}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        recommendedProductIndices.clear();
        recommendedProductIndices = List<int>.from(data['recommendations']);
        print(recommendedProductIndices);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    print(widget.recommend);
    print(widget.recommend.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.product_name),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Brand icon photo
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              child: Image.asset('images/${widget.data.brand}.png'),
            ),
            // Laptop image
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Image.asset('images/laptop.jpeg'),
            ),
            // Product details
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Brand: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.data.brand}'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Product Name: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.data.product_name}'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'Rs. ${widget.data.price}'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Screen Size: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.data.screen_size} inches'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Weight: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.data.weight} kg'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Annual Energy Demand: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.data.energy_demand} kWh'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Carbon Footprint: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '${widget.data.carbon_footprint} kg CO2'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Recommended products
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended Products with Less Carbon Footprint',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  // Recommended product cards
                  SizedBox(
                    height: 300, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: 5, // Number of recommended products
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: 200,
                            child: InkWell(
                                onTap: () async {
                                  int recommendedProductIndex = widget
                                          .recommend[
                                      index]; // Get the recommended product index
                                  await fetchRecommendations(
                                      recommendedProductIndex); // Fetch recommendations for the recommended product
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          data: widget.dataList[
                                              recommendedProductIndex],
                                          dataList: widget.dataList,
                                          recommend: recommendedProductIndices),
                                    ),
                                  );
                                },
                                child: buildProductCard(
                                    widget.dataList, widget.recommend[index]))

                            //child: buildProductCard(widget.dataList, widget.recommend[index])
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
