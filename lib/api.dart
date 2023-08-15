import 'dart:convert';
import 'package:http/http.dart' as http;

class Dataset {
   int S_no = 0;
   String brand = "";
   String product_name = "";
   double weight = 0.0;
   double screen_size = 0.0;
   double product_lifetime = 0.0;
   double energy_demand = 0.0;
   String assembly_location = "";
   String use_location = "";
   double manufacturing_impact = 0.0;
   double transportation_impact = 0.0;
   double end_of_life_impact = 0.0;
   double use_impact = 0.0;
   double carbon_footprint = 0.0;
   double price = 0.0;

  Dataset.one() {}

  Dataset(
      {required this.S_no,
      required this.brand,
      required this.product_name,
      required this.weight,
      required this.screen_size,
      required this.product_lifetime,
      required this.energy_demand,
      required this.assembly_location,
      required this.use_location,
      required this.manufacturing_impact,
      required this.transportation_impact,
      required this.end_of_life_impact,
      required this.use_impact,
      required this.carbon_footprint,
      required this.price});

  factory Dataset.fromJson(Map<String, dynamic> json) {
    return Dataset(
        S_no: json['S_no'],
        brand: json['brand'],
        product_name: json['product_name'],
        weight: json['weight (kg)'],
        screen_size: json['screen_size (in)'],
        product_lifetime: json['product_lifetime (yr)'],
        energy_demand: json['energy_demand (kWh)'],
        assembly_location: json['assembly_location'],
        use_location: json['use_location'],
        manufacturing_impact: json['manufacturing_impact (%)'],
        transportation_impact: json['transportation_impact (%)'],
        end_of_life_impact: json['end_of_life_impact (%)'],
        use_impact: json['use_impact (%)'],
        carbon_footprint: json['carbon_footprint (kg)'],
        price: json['price (in Rs)']);
  }

  List<Dataset> decodeDataset(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Dataset>((json) => Dataset.fromJson(json))
        .toList();
  }

  Future<List<Dataset>> fetchAll() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbw08tF8pg8Qi4-uwyqeZKefbTb2OWAKhVydTCBSLgqhJ5y59gpTBvcIX-LwKpX7RfTRRg/exec'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return decodeDataset(response.body);
    } else {
      throw Exception('failed to fetch data from API');
    }
  }
}
