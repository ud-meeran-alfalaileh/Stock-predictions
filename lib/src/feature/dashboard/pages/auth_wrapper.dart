import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocks_prediction/src/feature/dashboard/pages/dashboard_drawe.dart';
import 'package:stocks_prediction/src/feature/login/view/pages/login_page.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return DashboardDrawer();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
