import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/dashboard/controller/dashboard_controller.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';
import 'package:stocks_prediction/src/feature/stock/view/stock_drawe.dart';

class FavoritesPage extends StatelessWidget {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
            height: context.screenHeight * .8,
            width: context.screenWidth * .9,
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.fav.length,
                itemBuilder: (context, index) {
                  Stock stock = controller.fav[index];
                  return favoriteItem(
                    context,
                    stock.symbol,
                    stock.priceAvg50.toString(),
                    stock.price.toString(),
                    stock.dayHigh.toString(),
                    stock,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget favoriteItem(BuildContext context, String name, String price,
      String closing, String untilClose, Stock ss) {
    final DashboardController controller = Get.find();

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
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    controller.fav
                        .removeWhere((stock) => stock.symbol == ss.symbol);
                    controller.saveFavorites();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text tabelHeaderText(String title) {
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
}
