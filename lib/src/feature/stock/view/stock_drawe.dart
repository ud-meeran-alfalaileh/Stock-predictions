import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/dashboard/pages/dashboard_page.dart';
import 'package:stocks_prediction/src/feature/setting/view/setting_page.dart';
import 'package:stocks_prediction/src/feature/stock/controller/stock_controller.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';
import 'package:stocks_prediction/src/feature/stock/view/stock_prediction_page.dart';

class StrockDrawer extends StatelessWidget {
  const StrockDrawer({super.key, required this.ss});
  final Stock ss;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StocksController());
    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: context.screenHeight,
            width: context.screenWidth * 0.15,
            color: AppTheme.lightAppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: context.screenWidth * .2,
                    height: context.screenHeight * .1,
                    child: Image.asset("assets/icon.png")),
                const SizedBox(
                  height: 60,
                ),
                drawerButton("Predictions", Icons.menu_book_outlined, () {
                  controller.pageValue.value = 0;
                }),
                const SizedBox(
                  height: 30,
                ),
                drawerButton("Favorites", Icons.favorite_border, () {
                  controller.pageValue.value = 1;
                }),
                const SizedBox(
                  height: 30,
                ),
                drawerButton("Setting", Icons.settings, () {
                  controller.pageValue.value = 2;
                }),
                Spacer(),
                drawerButton("Logout", Icons.login, () {}),
              ],
            ),
          ),
          Obx(
            () => Container(
                padding: const EdgeInsets.all(35),
                height: context.screenHeight,
                width: context.screenWidth * 0.85,
                color: const Color.fromARGB(255, 241, 242, 248),
                child: controller.pageValue.value == 0
                    ? DashboardPage()
                    : controller.pageValue.value == 1
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            height: context.screenHeight,
                            width: context.screenWidth * 0.8,
                            color: const Color(0xffF8F9FD),
                          )
                        : controller.pageValue.value == 2
                            ? SettingPage()
                            : PredictionScreen(ss: ss)),
          )
        ],
      ),
    );
  }

  drawerButton(title, icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.lightAppColors.background,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppTheme.lightAppColors.background,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
