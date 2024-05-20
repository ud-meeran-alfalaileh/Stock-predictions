import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stocks_prediction/src/config/sizes/sizes.dart';
import 'package:stocks_prediction/src/config/theme/theme.dart';
import 'package:stocks_prediction/src/feature/login/model/login_form_model.dart';
import 'package:stocks_prediction/src/feature/login/model/user_model.dart';
import 'package:stocks_prediction/src/feature/login/view/pages/login_form_widget.dart';
import 'package:stocks_prediction/src/feature/login/view/pages/login_page.dart';
import 'package:stocks_prediction/src/feature/register/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final formkey = GlobalKey<FormState>();

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
                SizedBox(height: context.screenHeight * .15),
                Container(
                  padding: EdgeInsets.all(20),
                  width: context.screenWidth * .4,
                  height: context.screenHeight * .8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          AppTheme.lightAppColors.background.withOpacity(.8)),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const Text(
                          "REGISTER",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: context.screenHeight * .03,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.email,
                                enableText: false,
                                hintText: "Email",
                                invisible: false,
                                validator: (email) =>
                                    controller.validEmail(email!),
                                type: TextInputType.emailAddress,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .03,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.name,
                                enableText: false,
                                hintText: "Name",
                                invisible: false,
                                validator: (email) =>
                                    controller.validName(email!),
                                type: TextInputType.emailAddress,
                                inputFormat: [],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .03,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.phone,
                                enableText: false,
                                hintText: "Phone",
                                invisible: false,
                                validator: (email) =>
                                    controller.vaildPhoneNumber(email!),
                                type: TextInputType.emailAddress,
                                inputFormat: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onTap: null)),
                        SizedBox(
                          height: context.screenHeight * .03,
                        ),
                        FormWidget(
                            formModel: FormModel(
                                controller: controller.password,
                                enableText: false,
                                hintText: "Password",
                                invisible: true,
                                validator: (password) =>
                                    controller.vaildatePassword(password!),
                                type: TextInputType.text,
                                inputFormat: [],
                                onTap: null)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              controller.onSignup(UserModel(
                                  name: controller.name.text.trim(),
                                  email: controller.email.text.trim(),
                                  password: controller.password.text.trim(),
                                  imageUrl: '',
                                  phone: controller.phone.text.trim()));
                              //  UserController.instance.logIn();
                            } else {}
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
                                "Register",
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
                              Get.to(LoginPage());
                            },
                            child: const Text(
                              "Have Account ? Login ",
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
