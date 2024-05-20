import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/dashboard/controller/dashboard_controller.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';
import 'package:stocks_prediction/src/feature/stock/view/stock_drawe.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Stock> stocks = [];
  final controller = Get.put(DashboardController());

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStocks();
    controller.loadFavorites();
  }

  Future<void> fetchStocks() async {
    final response = await http.get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/symbol/NASDAQ?apikey=Nqkr4PabNdt3IXAOqvR6WzhwFLldTqKj'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      controller.stocksData.value = data;
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search by name or symbol',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (value) {
              controller.searchQuery.value = value;
            },
          ),
          Container(
            padding: const EdgeInsets.all(25),
            width: context.screenWidth,
            height: context.screenHeight * .1,
            decoration: BoxDecoration(
              color: AppTheme.lightAppColors.background,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: const FractionColumnWidth(.01),
              children: [
                TableRow(children: [
                  tabelHeaderText(""),
                  tabelHeaderText("Name"),
                  tabelHeaderText("Price"),
                  tabelHeaderText("Closing Price"),
                  tabelHeaderText("Time Until Close"),
                  tabelHeaderText(""),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: context.screenHeight * .7,
            width: context.screenWidth * .9,
            child: Obx(() {
              final filteredStocks = controller.filteredStocks;
              return ListView.builder(
                itemCount: filteredStocks.length,
                itemBuilder: (context, index) {
                  return dashboardItem(
                    context,
                    filteredStocks[index].symbol,
                    filteredStocks[index].priceAvg50.toString(),
                    filteredStocks[index].price.toString(),
                    filteredStocks[index].dayHigh.toString(),
                    filteredStocks[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  dashboardItem(BuildContext context, String name, String price, String closing,
      String untilClose, Stock ss) {
    bool isFavorite = controller.fav.any((stock) => stock.symbol == ss.symbol);

    return GestureDetector(
      onTap: () {
        Get.to(StrockDrawer(ss: ss));
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        width: context.screenWidth,
        height: context.screenHeight * .1,
        decoration: BoxDecoration(
          color: AppTheme.lightAppColors.background,
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: const FractionColumnWidth(.01),
          children: [
            TableRow(
              children: [
                tabelHeaderText(""),
                tabelHeaderText(name),
                tabelHeaderText(price),
                tabelHeaderText(closing),
                tabelHeaderText(untilClose),
                IconButton(
                  icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        controller.fav
                            .removeWhere((stock) => stock.symbol == ss.symbol);
                      } else {
                        controller.fav.add(ss);
                      }
                      controller.saveFavorites();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Text tabelHeaderText(title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: AppTheme.lightAppColors.bordercolor),
    ),
  );
}
