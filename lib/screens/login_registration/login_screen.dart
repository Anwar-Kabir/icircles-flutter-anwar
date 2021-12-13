import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:icircles/screens/login_registration/registration_screen.dart';
import 'package:icircles/screens/videos/videos_screen.dart';
import 'package:icircles/screens/login_registration/forgot_password_screen.dart';
import 'package:icircles/screens/login_registration/header.dart';
import 'package:icircles/screens/login_registration/login_register_button.dart';
import 'package:icircles/screens/login_registration/social_login.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController _userController = Get.find();
  String? email = "";
  String? password = "";
  bool passwordHidden = true;
  bool rememberMeChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    AppCon.widget.loadConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: AppCon.widget.appBackground(context)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const LoginRegisterHeader(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Image.asset(
                    AppCon.image.loginAvatar,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  usernameField(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  passwordField(context),
                  // forgot password
                  GestureDetector(
                    onTap: () {
                      Get.to(const ForgotPasswordScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.width * 0.14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "forgot password?".toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: AppCon.color.textColor1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Remember me
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rememberMeChecked = !rememberMeChecked;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.14,
                      ),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            rememberMeChecked
                                ? Icons.check_box
                                : Icons.check_box_outline_blank_rounded,
                            color: AppCon.color.textColor1,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            "Remember me".toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.50)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  loginRegisterButton(
                    context,
                    text: "Sign In",
                    onTap: () {
                      _formKey.currentState!.save();
                      if (email == "" || password == "") {
                        Get.snackbar(
                          "Error",
                          "Email and password field can't be empty!f",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red[100],
                        );
                      } else {
                        AppCon.widget.loadingOverlay();
                        http.post(Uri.parse("https://icircles.app/api/login"),
                            body: {
                              'email': email,
                              'pass': password,
                            }).then((value) {
                          var response = jsonDecode(value.body);
                          if (response['status']) {
                            var token = response['token'];
                            Get.snackbar(
                              "Login Success",
                              "Sit tight, we are getting things ready for you",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green[100],
                            );
                            http.post(Uri.parse(AppCon.api.profile),
                                body: {"token": token}).then((value) {
                              var response = jsonDecode(value.body);
                              if (response['status']) {
                                _userController.setLoginData(response, token,
                                    remember: true);
                                Get.offAll(
                                  const VideosScreen(),
                                );
                              }
                            });
                          } else {
                            Get.back();
                            AppCon.widget.popUp(
                              context,
                              text: response['message'],
                              barrierDismissible: true,
                              okButtonText: "Okay",
                              onOkButtonTap: () {
                                Get.back();
                              },
                            );
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Or use social sign in",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.50)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  socialLogin(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white.withOpacity(0.60)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(
                            const RegisterScreen(),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                          ),
                          color: Colors.transparent,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: AppCon.color.textColor1.withOpacity(0.60),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: AppCon.color.inputFieldBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            onSaved: (value) {
              email = value;
            },
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              icon: Icon(
                Icons.account_circle,
                color: AppCon.color.textColor1,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
              labelText: "Email or Username",
              labelStyle: TextStyle(
                color: Colors.white.withOpacity(
                  0.42,
                ),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: AppCon.color.inputFieldBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              onSaved: (value) {
                password = value;
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              obscureText: passwordHidden,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: AppCon.color.textColor1,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(
                    0.42,
                  ),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                passwordHidden = !passwordHidden;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Icon(
                passwordHidden ? Icons.visibility : Icons.visibility_off,
                color: AppCon.color.textColor1,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          )
        ],
      ),
    );
  }
}
