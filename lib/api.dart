import 'dart:convert';
import 'package:http/http.dart' as http;

class Dataset {
  final int S_no;
  final String brand;
  final String product_name;
  final double weight;
  final double screen_size;
  final double product_lifetime;
  final double energy_demand;
  final String assembly_location;
  final String use_location;
  final double manufacturing_impact;
  final double transportation_impact;
  final double end_of_life_impact;
  final double use_impact;
  final double carbon_footprint;
  final double price;

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

  static Future<List<Dataset>> fetchAll() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbw08tF8pg8Qi4-uwyqeZKefbTb2OWAKhVydTCBSLgqhJ5y59gpTBvcIX-LwKpX7RfTRRg/exec'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Dataset.fromJson(data)).toList();
    } else {
      throw Exception('failed to fetch data from API');
    }
  }
}
