import 'dart:convert';
import 'package:crypto_demo/crypto_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://coinranking1.p.rapidapi.com/coins';

  static const Map<String, String> headers = {
    'X-RapidAPI-Key': '93e8e796d1mshcbf9cffb6981f8bp1bfe63jsn0095d53d27cb',
    'X-RapidAPI-Host': 'coinranking1.p.rapidapi.com',
  };

  static Future<List<CryptoModel>> fetchCoins() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> coins = data['data']['coins'];

        return coins.map((coinJson) => CryptoModel.fromJson(coinJson)).toList();
      } else {
        throw Exception('Failed to load coins');
      }
    } catch (e) {
      print('Error fetching coins: $e');
      throw Exception('Something went wrong');
    }
  }
}
