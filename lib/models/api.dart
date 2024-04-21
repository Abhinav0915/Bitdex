import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<List> fetchCryptoData() async {
    final response = await http.get(
        Uri.parse(
            'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'),
        headers: {'X-CMC_PRO_API_KEY': '4b3df8c1-8866-4171-b40b-24d84795532b'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final cryptoData = jsonResponse['data'];
      return cryptoData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}