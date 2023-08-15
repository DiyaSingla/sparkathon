import 'package:flutter/material.dart';
import 'package:sparkathon_app/page.dart';

import 'api.dart';
import 'homepage.dart';

void main() {
  runApp(
    MyApp(),
  );
}

var d = Dataset.one();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(data: d.fetchAll()),
    );
  }
}
