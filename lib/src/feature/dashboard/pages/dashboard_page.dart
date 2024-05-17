import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';
import 'package:stocks_prediction/src/feature/stock/view/stock_drawe.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    fetchStocks();
  }

  Future<void> fetchStocks() async {
    final response = await http.get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/symbol/NASDAQ?apikey=Nqkr4PabNdt3IXAOqvR6WzhwFLldTqKj'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        stocks = data.map((item) => Stock.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(25),
            width: context.screenWidth,
            height: context.screenHeight * .1,
            decoration: BoxDecoration(
              color: AppTheme.lightAppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            )),
        SizedBox(
          height: context.screenHeight * .8,
          width: context.screenWidth * .9,
          child: ListView.builder(
              itemCount: stocks.length == 0 ? 0 : stocks.length,
              itemBuilder: (context, index) {
                return dashboardItem(
                    context,
                    stocks[index].symbol,
                    stocks[index].priceAvg50.toString(),
                    stocks[index].price.toString(),
                    stocks[index].dayHigh.toString(),
                    Stock(
                        symbol: stocks[index].symbol,
                        name: stocks[index].name,
                        price: stocks[index].price,
                        dayLow: stocks[index].dayLow,
                        dayHigh: stocks[index].dayHigh,
                        yearHigh: stocks[index].yearHigh,
                        yearLow: stocks[index].yearLow,
                        priceAvg50: stocks[index].priceAvg50,
                        priceAvg200: stocks[index].priceAvg200,
                        exchange: stocks[index].exchange));
              }),
        )
      ],
    );
  }

  dashboardItem(
      BuildContext context, name, price, closing, untilClose, Stock ss) {
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
              TableRow(children: [
                tabelHeaderText(""),
                tabelHeaderText(name),
                tabelHeaderText(price),
                tabelHeaderText(closing),
                tabelHeaderText(untilClose),
                tabelHeaderText(""),
              ]),
            ],
          )),
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
            color: AppTheme.lightAppColors.bordercolor)),
  );
}
