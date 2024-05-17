import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  RxInt pageValue = 0.obs;
  RxList<dynamic> stocksData = <dynamic>[].obs;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/symbol/NASDAQ?apikey=Nqkr4PabNdt3IXAOqvR6WzhwFLldTqKj'));
    if (response.statusCode == 200) {
      stocksData = json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
