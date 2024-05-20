import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';

class DashboardController extends GetxController {
  RxInt pageValue = 0.obs;
  RxList<dynamic> stocksData = <dynamic>[].obs;
  RxList<Stock> fav = <Stock>[].obs;
  RxString searchQuery = ''.obs;

  Future<void> saveFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favJsonList =
        fav.map((stock) => json.encode(stock.toJson())).toList();
    await prefs.setStringList('favorites', favJsonList);
  }

  Future<void> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favJsonList = prefs.getStringList('favorites') ?? [];
    fav.value = favJsonList
        .map((stockJson) => Stock.fromJson(json.decode(stockJson)))
        .toList();
  }

  // Future<void> fetchData() async {
  //   final response = await http.get(Uri.parse(
  //       'https://financialmodelingprep.com/api/v3/symbol/NASDAQ?apikey=Nqkr4PabNdt3IXAOqvR6WzhwFLldTqKj'));
  //   if (response.statusCode == 200) {
  //     stocksData.value = json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
//search
  List<Stock> get filteredStocks {
    if (searchQuery.value.isEmpty) {
      return stocksData.map((item) => Stock.fromJson(item)).toList();
    } else {
      return stocksData
          .map((item) => Stock.fromJson(item))
          .where((stock) =>
              stock.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              stock.symbol
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }
}
