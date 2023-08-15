import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';

class ProductPage extends StatelessWidget {
  final Dataset data;

  const ProductPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.product_name),
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
              child: Image.asset('images/${data.brand}.png'),
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
                  Text('Brand: ${data.brand}'),
                  Text('Product Name: ${data.product_name}'),
                  Text('Price: Rs. ${data.price}'),
                  Text('Screen Size: ${data.screen_size} inches'),
                  Text('Weight: ${data.weight} kg'),
                  Text('Annual Energy Demand: ${data.energy_demand} kWh'),
                  Text('Carbon Footprint: ${data.carbon_footprint} kg CO2'),
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
                    'Recommended Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // Recommended product cards
                  SizedBox(
                    height: 220, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Number of recommended products
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 150,
                          child: Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              // Add recommended product content here
                              child: Text('Recommended Product $index'),
                            ),
                          ),
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
