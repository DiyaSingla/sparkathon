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
    return const MaterialApp(
      title: "SustainPick",
      debugShowCheckedModeBanner: false,
      home: MyLogoPage(
        title: "SustainPick",
      ),
    );
  }
}
