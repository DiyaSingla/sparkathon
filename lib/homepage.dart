import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';

class MyHomePage extends StatelessWidget {
  final Future<List<Dataset>> data;

  const MyHomePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Dataset>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              return dataList(snapshot.data!);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget dataList(List<Dataset> dataList) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataList[index].brand,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
