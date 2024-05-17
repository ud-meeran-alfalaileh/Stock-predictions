import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/dashboard/pages/dashboard_page.dart';
import 'package:stocks_prediction/src/feature/stock/controller/stock_controller.dart';
import 'package:stocks_prediction/src/feature/stock/model/stock_model.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key, required this.ss});
  final Stock ss;
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final controller = Get.put(StocksController());
  late Future<Prediction> futurePrediction;

  @override
  void initState() {
    super.initState();
    futurePrediction = controller.fetchPrediction(widget.ss.symbol);
  }

//   arimaAccuracy: json['arima_accuracy'],
  // arimaPrediction: json['arima_prediction'],
  // arimaRmse: json['arima_rmse'],
  // image: json['image'],
  // quote: json['quote'],
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Prediction>(
        future: futurePrediction,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final prediction = snapshot.data!;
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.screenHeight * 0.15,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 100),
                        width: context.screenWidth * .7,
                        height: context.screenHeight * .1,
                        decoration: BoxDecoration(
                          color: AppTheme.lightAppColors.background,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          defaultColumnWidth: const FractionColumnWidth(.01),
                          children: [
                            TableRow(children: [
                              tabelHeaderText(" "),
                              tabelHeaderText("ARIMA Accuracy"),
                              tabelHeaderText("ARIMA Prediction"),
                              tabelHeaderText("ARIMA RMSE"),
                            ]),
                            TableRow(children: [
                              Text(
                                prediction.quote,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800)),
                              ),
                              tabelHeaderText("${prediction.arimaAccuracy}%"),
                              tabelHeaderText(
                                  prediction.arimaPrediction.toString()),
                              tabelHeaderText(prediction.arimaRmse.toString()),
                            ]),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 100),
                          child: Image.network(
                              'http://127.0.0.1:5000/${prediction.image}'),
                        ),
                        SizedBox(
                          width: context.screenWidth * 0.2,
                        ),
                        Container(
                            padding: const EdgeInsets.all(25),
                            width: context.screenHeight * .4,
                            height: context.screenHeight * 0.5,
                            decoration: BoxDecoration(
                                color: AppTheme.lightAppColors.primary
                                    .withOpacity(0.2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                predictionText("Name :${widget.ss.name}"),
                                predictionText(
                                    "Exchange :${widget.ss.exchange}"),
                                predictionText("Price :${widget.ss.price}"),
                                predictionText(
                                    "Year High :${widget.ss.yearHigh}"),
                                predictionText(
                                    "Year Low :${widget.ss.yearLow}"),
                                predictionText(
                                    "Day High :${widget.ss.dayHigh}"),
                                predictionText(
                                    "Price Avg 200 :${widget.ss.priceAvg200}"),
                                predictionText(
                                    "Price Avg 50 :${widget.ss.priceAvg50}"),
                                predictionText("Name :${widget.ss.name}"),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }

  Text predictionText(title) => Text(
        title,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        )),
      );
}
