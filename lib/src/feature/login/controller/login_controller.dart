import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stocks_prediction/src/feature/dashboard/pages/dashboard_drawe.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  emailValid(String email) {
    if (GetUtils.isEmail(email)) {
      return null;
    } else {
      return "Fill the Field";
    }
  }

  vaildPassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return "'Invalid password'".tr;
    }
    return null;
  }

  Future<bool> login(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future onLogin() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print("object");

      Get.to(DashboardDrawer());
    } on FirebaseAuthException {
      Get.snackbar("ERROR", "Email or Password is invild",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }
}
