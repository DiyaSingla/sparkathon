import 'package:flutter/material.dart';

import 'logo_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black, // Set the primary color to black
      ),
      debugShowCheckedModeBanner: false,
      home: MyLogoPage(
        title: "CO2",
      ),
    );
  }
}
