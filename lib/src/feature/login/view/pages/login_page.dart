import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/core/auth_repo/user_repo.dart';
import 'package:stocks_prediction/src/feature/login/controller/login_controller.dart';
import 'package:stocks_prediction/src/feature/login/model/login_form_model.dart';
import 'package:stocks_prediction/src/feature/login/view/pages/login_form_widget.dart';
import 'package:stocks_prediction/src/feature/register/view/page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final userRepo = Get.put(UserRepository());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.screenHeight * .17,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: context.screenWidth * .4,
                  height: context.screenHeight * .75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          AppTheme.lightAppColors.background.withOpacity(.8)),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      children: [
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: context.screenHeight * .17,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.email,
                                enableText: false,
                                hintText: "Email",
                                invisible: false,
                                validator: (email) =>
                                    controller.emailValid(email!),
                                type: TextInputType.emailAddress,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .05,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.password,
                                enableText: false,
                                hintText: "Password",
                                invisible: false,
                                validator: (password) =>
                                    controller.vaildPassword(password!),
                                type: TextInputType.text,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .07,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.formkey.currentState!.validate()) {
                              controller.onLogin();
                              // userRepo
                              //     .getUserDetails(controller.email.text.trim());
                            }
                          },
                          child: Container(
                            width: context.screenWidth,
                            height: context.screenHeight * .08,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppTheme.lightAppColors.maincolor
                                    .withOpacity(.2)),
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: AppTheme.lightAppColors.background,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(RegisterPage());
                            },
                            child: const Text(
                              "Don’t have an account? Sign up  ",
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                  width: context.screenWidth * .2,
                  height: context.screenHeight * .1,
                  child: Image.asset("assets/icon.png")))
        ],
      ),
    );
  }
}
