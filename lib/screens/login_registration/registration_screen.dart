// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/screens/login_registration/header.dart';
import 'package:icircles/screens/login_registration/login_register_button.dart';
import 'package:icircles/screens/login_registration/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:icircles/screens/login_registration/social_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool formError = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:
              BoxDecoration(image: AppCon.widget.appBackground(context)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const LoginRegisterHeader(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      textField(
                        context,
                        hintText: "First name",
                        icon: Icons.remember_me,
                        onSaved: (value) {
                          firstName = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textField(
                        context,
                        hintText: "Last name",
                        icon: Icons.remember_me,
                        onSaved: (value) {
                          lastName = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textField(
                        context,
                        hintText: "Username",
                        icon: Icons.person,
                        onSaved: (value) {
                          username = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textField(
                        context,
                        hintText: "Email",
                        icon: Icons.email,
                        onSaved: (value) {
                          email = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textField(
                        context,
                        hintText: "Password",
                        icon: Icons.lock,
                        obsecureText: true,
                        onSaved: (value) {
                          password = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textField(
                        context,
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                        obsecureText: true,
                        onSaved: (value) {
                          confirmPassword = value;
                        },
                        validator: (value, hintText) {
                          if (value == "") {
                            return '$hintText can\'t be empty!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      loginRegisterButton(
                        context,
                        text: "Sign Up",
                        onTap: () {
                          formError = false;
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            if (password != confirmPassword) {
                              Get.snackbar(
                                "Error",
                                "Password and confirm password doesn't matches",
                                backgroundColor: Colors.red[100],
                              );
                              return;
                            } else {
                              AppCon.widget.loadingOverlay();
                              http.post(Uri.parse(AppCon.api.register), body: {
                                "firstname": firstName,
                                "lastname": lastName,
                                "username": username,
                                "email": email,
                                "password": password,
                                "password2": confirmPassword,
                              }).then((value) {
                                var response = jsonDecode(value.body);
                                if (response['status']) {
                                  Get.back();
                                  Get.defaultDialog(
                                      title: "Registration Success",
                                      middleText: response['message'],
                                      barrierDismissible: false,
                                      textConfirm: "Login",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Get.back();
                                        Get.off(const LoginScreen());
                                      });
                                } else {
                                  Get.back();
                                  Get.defaultDialog(
                                      title: "Registration Failed",
                                      middleText: response['message'],
                                      barrierDismissible: false,
                                      textConfirm: "Try Again",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Get.back();
                                      });
                                }
                              }).catchError((onError) {
                                Get.back();
                                AppCon.widget.errorDialog(() {
                                  Get.back();
                                });
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(const LoginScreen());
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.008,
                          ),
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "-- -- -- -- -- -- --",
                                  style: TextStyle(
                                    color: AppCon.color.textColor1,
                                  ),
                                ),
                                const TextSpan(
                                  text: "  Or sign up with  ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: "-- -- -- -- -- -- --",
                                  style: TextStyle(
                                    color: AppCon.color.textColor1,
                                  ),
                                ),
                              ],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.60),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      socialLogin(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  textField(BuildContext context,
      {@required hintText,
      @required icon,
      @required onSaved,
      @required validator,
      obsecureText = false}) {
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
            obscureText: obsecureText,
            onSaved: onSaved,
            validator: (value) {
              return validator(value, hintText);
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
              labelText: hintText,
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
}
