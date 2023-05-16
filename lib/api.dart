import 'dart:convert';

import 'package:api_reference/number_model_response.dart';
import 'package:http/http.dart' as http;

Future<NumberModelResponse> getDataFromServer({required int number}) async {
  final _response =
      await http.get(Uri.parse('http://numbersapi.com/$number?json'));
  final jsonResponse = jsonDecode(_response.body) as Map<String, dynamic>;
  return NumberModelResponse.fromJson(jsonResponse);
}
