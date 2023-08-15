import 'package:flutter/material.dart';

import 'api.dart';

Widget buildProductCard(List<Dataset> dataList, int index) {
  return Card(
    elevation: 5,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              '${dataList[index].carbon_footprint} kg CO2 eq.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // Circular brand logo image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/${dataList[index].brand}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 3), // Spacing between image and text content
          Text(
            dataList[index].brand,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            child: Text(
              '\n' + dataList[index].product_name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            child: Text(
              '\n' + 'Rs.' + dataList[index].price.toString(),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Container(
            child: Text(
              '\n' +
                  dataList[index].screen_size.toString() +
                  ' inches  |  ' +
                  dataList[index].weight.toString() +
                  ' kg',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
