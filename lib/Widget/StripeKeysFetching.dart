import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeKeysFetcher {
  static Future<Map<String, String>> fetchStripeKeys() async {
    final response = await http.get(Uri.parse('https://autohauscarrental.eigix.net/api/get_stripe_keys'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        final List<dynamic> keys = data['data'];
        return {
          'publishableKey': keys.firstWhere((key) => key['keys_type'] == 'Publishable')['key'],
          'secretKey': keys.firstWhere((key) => key['keys_type'] == 'Secret')['key'],
        };
      } else {
        throw Exception('Failed to load Stripe keys');
      }
    } else {
      throw Exception('Failed to load Stripe keys');
    }
  }
}