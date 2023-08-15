import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';

class Items extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Items> {
  var d = Dataset.one();
  List<Dataset> Items = [];

  Future<void> addValue() async {
    Items = await d.fetchAll();
    print(Items);
  }

  @override
  void initState(){
    super.initState();
    addValue();
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronics'),
      ),
      body: ListView.builder(
          itemCount: Items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Items[index].brand),
              subtitle: Text(Items[index].product_name),
              trailing: Icon(
                Icons.laptop,
              ),
            );
          }),
    );
  }
}
