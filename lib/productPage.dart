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
  List<Dataset> finalData = [];

  Future<void> fetchRecommendations(int product_index) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/recommendations/${product_index}'));

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
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
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
                  Text('Brand: ${widget.data.brand}'),
                  Text('Product Name: ${widget.data.product_name}'),
                  Text('Price: Rs. ${widget.data.price}'),
                  Text('Screen Size: ${widget.data.screen_size} inches'),
                  Text('Weight: ${widget.data.weight} kg'),
                  Text(
                      'Annual Energy Demand: ${widget.data.energy_demand} kWh'),
                  Text(
                      'Carbon Footprint: ${widget.data.carbon_footprint} kg CO2'),
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
                                  await fetchRecommendations(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          data: widget.dataList[
                                              widget.recommend[index]],
                                          dataList: finalData,
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
