// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:stocks_prediction/src/feature/dashboard/controller/profile_controller.dart';
// // // import 'package:stocks_prediction/src/feature/dashboard/pages/dashboard_drawe.dart';
// // // import 'package:stocks_prediction/src/feature/login/view/pages/login_page.dart';

// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp();
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: AuthWrapper(),
// // //     );
// // //   }
// // // }

// // // class AuthWrapper extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return StreamBuilder<User?>(
// // //       stream: FirebaseAuth.instance.authStateChanges(),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return CircularProgressIndicator();
// // //         } else if (snapshot.hasData) {
// // //           return DashboardDrawer();
// // //         } else {
// // //           return LoginPage();
// // //         }
// // //       },
// // //     );
// // //   }
// // // }

// // // class HomeScreen extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Home'),
// // //         actions: [
// // //           IconButton(
// // //             icon: Icon(Icons.logout),
// // //             onPressed: () async {
// // //               await FirebaseAuth.instance.signOut();
// // //             },
// // //           )
// // //         ],
// // //       ),
// // //       body: Center(child: Text('Welcome!')),
// // //     );
// // //   }
// // // }

// // // class LoginScreen extends StatelessWidget {
// // //   final TextEditingController emailController = TextEditingController();
// // //   final TextEditingController passwordController = TextEditingController();

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Padding(
// // //         padding: EdgeInsets.all(16.0),
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             TextField(
// // //               controller: emailController,
// // //               decoration: InputDecoration(labelText: 'Email'),
// // //             ),
// // //             TextField(
// // //               controller: passwordController,
// // //               decoration: InputDecoration(labelText: 'Password'),
// // //               obscureText: true,
// // //             ),
// // //             SizedBox(height: 20),
// // //             ElevatedButton(
// // //               onPressed: () async {
// // //                 try {
// // //                   await FirebaseAuth.instance.signInWithEmailAndPassword(
// // //                     email: emailController.text,
// // //                     password: passwordController.text,
// // //                   );
// // //                 } catch (e) {
// // //                   print(e); // Handle error appropriately
// // //                 }
// // //               },
// // //               child: Text('Login'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class PostPage extends StatefulWidget {
// // //   const PostPage({super.key});

// // //   @override
// // //   State<PostPage> createState() => _PostPageState();
// // // }

// // // class _PostPageState extends State<PostPage> {
// // //   final controller = Get.put(ProfileController());

// // //   @override
// // //   void dispose() {
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return FutureBuilder(
// // //         future: controller.getUserDatar(),
// // //         builder: (context, snapShot) {
// // //           if (snapShot.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           } else if (snapShot.connectionState == ConnectionState.done) {
// // //             if (snapShot.hasData) {
// // //               return Scaffold(
// // //                 body: Container(),
// // //               );
// // //             } else if (snapShot.hasError) {
// // //               return Center(child: Text('Error${snapShot.error}'));
// // //             } else {
// // //               return const Center(child: CircularProgressIndicator());
// // //             }
// // //           } else {
// // //             return const Center(child: CircularProgressIndicator());
// // //           }
// // //         });
// // //   }
// // // }
// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class Prediction {
// //   final double arimaAccuracy;
// //   final double arimaPrediction;
// //   final double arimaRmse;
// //   final String image;
// //   final String quote;

// //   Prediction({
// //     required this.arimaAccuracy,
// //     required this.arimaPrediction,
// //     required this.arimaRmse,
// //     required this.image,
// //     required this.quote,
// //   });

// //   factory Prediction.fromJson(Map<String, dynamic> json) {
// //     return Prediction(
// //       arimaAccuracy: json['arima_accuracy'],
// //       arimaPrediction: json['arima_prediction'],
// //       arimaRmse: json['arima_rmse'],
// //       image: json['image'],
// //       quote: json['quote'],
// //     );
// //   }
// // }

// // Future<Prediction> fetchPrediction(String quote) async {
// //   final response = await http.get(Uri.parse(
// //       'http://127.0.0.1:5000/predict?quote=googl')); // Use your ngrok URL

// //   if (response.statusCode == 200) {
// //     return Prediction.fromJson(jsonDecode(response.body));
// //   } else {
// //     throw Exception('Failed to load prediction');
// //   }
// // }

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: PredictionScreen(),
// //     );
// //   }
// // }

// // class PredictionScreen extends StatefulWidget {
// //   @override
// //   _PredictionScreenState createState() => _PredictionScreenState();
// // }

// // class _PredictionScreenState extends State<PredictionScreen> {
// //   late Future<Prediction> futurePrediction;

// //   @override
// //   void initState() {
// //     super.initState();
// //     futurePrediction = fetchPrediction('googl');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Stock Prediction'),
// //       ),
// //       body: Center(
// //         child: FutureBuilder<Prediction>(
// //           future: futurePrediction,
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return CircularProgressIndicator();
// //             } else if (snapshot.hasError) {
// //               return Text('Error: ${snapshot.error}');
// //             } else if (snapshot.hasData) {
// //               final prediction = snapshot.data!;
// //               return Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   Text('Quote: ${prediction.quote}'),
// //                   Text('ARIMA Accuracy: ${prediction.arimaAccuracy}%'),
// //                   Text('ARIMA Prediction: ${prediction.arimaPrediction}'),
// //                   Text('ARIMA RMSE: ${prediction.arimaRmse}'),
// //                   Image.network(
// //                       'http://127.0.0.1:5000/${prediction.image}'), // Adjust URL accordingly
// //                 ],
// //               );
// //             } else {
// //               return Text('No data');
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocks App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StockPage(),
    );
  }
}

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List<dynamic> stocksData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/symbol/NASDAQ?apikey=Nqkr4PabNdt3IXAOqvR6WzhwFLldTqKj'));
    if (response.statusCode == 200) {
      setState(() {
        stocksData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: ListView.builder(
        itemCount: stocksData.length,
        itemBuilder: (context, index) {
          final stock = stocksData[index];
          return ListTile(
            title: Text(stock['symbol']),
            subtitle: Text('Price: ${stock['price']}'),
            trailing: Text('Change: ${stock['change']}'),
          );
        },
      ),
    );
  }
}
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stocks App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StockPage(),
//     );
//   }
// }

// class StockPage extends StatefulWidget {
//   @override
//   _StockPageState createState() => _StockPageState();
// }

// class _StockPageState extends State<StockPage> {
//   String stocksData = "";

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(
//         Uri.parse('http://192.168.1.64:8080/ask?query=what is python'),
//         headers: {'Accept': 'application/json'});
//     if (response.statusCode == 200) {
//       setState(() {
//         stocksData = json.decode(response.body)['response'];
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Stocks'),
//         ),
//         body: Text(stocksData));
//   }
// }
