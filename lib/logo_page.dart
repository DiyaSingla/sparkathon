import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sparkathon_app/homepage.dart';

import 'api.dart';

class MyLogoPage extends StatefulWidget {
  const MyLogoPage({super.key, required this.title});

  final String title;

  @override
  State<MyLogoPage> createState() => _MyLogoPageState();
}

class _MyLogoPageState extends State<MyLogoPage> {
  var d = Dataset.one();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(data: d.fetchAll())));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Set the background color to black
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/sustainix_logo.png'),
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
