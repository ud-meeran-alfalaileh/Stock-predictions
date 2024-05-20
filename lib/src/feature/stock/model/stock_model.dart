class Prediction {
  final double arimaAccuracy;
  final double arimaPrediction;
  final double arimaRmse;
  final String image;
  final String quote;

  Prediction({
    required this.arimaAccuracy,
    required this.arimaPrediction,
    required this.arimaRmse,
    required this.image,
    required this.quote,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      arimaAccuracy: json['arima_accuracy'],
      arimaPrediction: json['arima_prediction'],
      arimaRmse: json['arima_rmse'],
      image: json['image'],
      quote: json['quote'],
    );
  }
}

class Stock {
  final String symbol;
  final String name;
  final double price;
  final double dayLow;
  final double dayHigh;
  final double yearHigh;
  final double yearLow;
  final double priceAvg50;
  final double priceAvg200;
  final String exchange;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.dayLow,
    required this.dayHigh,
    required this.yearHigh,
    required this.yearLow,
    required this.priceAvg50,
    required this.priceAvg200,
    required this.exchange,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      dayLow: json['dayLow']?.toDouble() ?? 0.0,
      dayHigh: json['dayHigh']?.toDouble() ?? 0.0,
      yearHigh: json['yearHigh']?.toDouble() ?? 0.0,
      yearLow: json['yearLow']?.toDouble() ?? 0.0,
      priceAvg50: json['priceAvg50']?.toDouble() ?? 0.0,
      priceAvg200: json['priceAvg200']?.toDouble() ?? 0.0,
      exchange: json['exchange'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
      'dayLow': dayLow,
      'dayHigh': dayHigh,
      'yearHigh': yearHigh,
      'yearLow': yearLow,
      'priceAvg50': priceAvg50,
      'priceAvg200': priceAvg200,
      'exchange': exchange,
    };
  }
}
