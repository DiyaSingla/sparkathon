import 'package:flutter/material.dart';
import 'package:sparkathon_app/api.dart';
import 'package:sparkathon_app/productPage.dart';

class HomePage extends StatelessWidget {
  final Future<List<Dataset>> data;

  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbonix'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder<List<Dataset>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              List<Dataset> shuffledData = List.from(snapshot.data!)..shuffle();
              return dataList(shuffledData);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget dataList(List<Dataset> dataList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 2, // Spacing between columns
        mainAxisSpacing: 2, // Spacing between rows
      ),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              // Handle card tap event here
              // You can navigate to a new page or perform any other action
              // For example, you can use Navigator to navigate to a new page:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(data: dataList[index]),
                ),
              );
            },
            child: Card(
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
                          image:
                              AssetImage('images/${dataList[index].brand}.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 3), // Spacing between image and text content
                    Text(
                      dataList[index].brand,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            ));
      },
    );
  }
}
