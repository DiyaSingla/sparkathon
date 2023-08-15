import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sheet2DataScreen extends StatefulWidget {
  @override
  _Sheet2DataScreenState createState() => _Sheet2DataScreenState();
}

class _Sheet2DataScreenState extends State<Sheet2DataScreen> {
  List<Map<String, dynamic>> sheet2Data = [];

  Future<void> fetchSheet2Data() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbw08tF8pg8Qi4-uwyqeZKefbTb2OWAKhVydTCBSLgqhJ5y59gpTBvcIX-LwKpX7RfTRRg/exec'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        sheet2Data = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSheet2Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheet 2 Data'),
      ),
      body: ListView.builder(
        itemCount: sheet2Data.length,
        itemBuilder: (context, index) {
          final item = sheet2Data[index];
          return ListTile(
            title: Text(item['brand']),
            subtitle: Text(item['product name']),
            // Display more fields here
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Sheet2DataScreen(),
  ));
}
