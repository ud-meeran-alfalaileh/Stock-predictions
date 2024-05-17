import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';

class StocksController extends GetxController {
  RxInt pageValue = 4.obs;
  Future<Prediction> fetchPrediction(String quote) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/predict?quote=$quote')); // Use your ngrok URL
    print(quote);
    if (response.statusCode == 200) {
      return Prediction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load prediction');
    }
  }
}
