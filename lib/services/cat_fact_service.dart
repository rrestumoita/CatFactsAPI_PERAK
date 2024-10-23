import 'dart:convert';
import 'package:http/http.dart' as http;

// Define CatFact model
class CatFact {
  final String fact;
  final int length;

  CatFact({required this.fact, required this.length});

  factory CatFact.fromJson(Map<String, dynamic> json) {
    return CatFact(
      fact: json['fact'],
      length: json['length'],
    );
  }
}

// Service to fetch cat facts from the API
class CatFactService {
  static const String apiUrl = 'https://catfact.ninja/fact';

  Future<CatFact> fetchCatFact() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return CatFact.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load cat fact');
    }
  }
}
