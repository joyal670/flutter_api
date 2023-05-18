import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/number_model_response.dart';

Future<NumberModelResponse> getDataFromServer({required int number}) async {
  final _response =
      await http.get(Uri.parse('http://numbersapi.com/$number?json'));
  final jsonResponse = jsonDecode(_response.body) as Map<String, dynamic>;
  return NumberModelResponse.fromJson(jsonResponse);
}
