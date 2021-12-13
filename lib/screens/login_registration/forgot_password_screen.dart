import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCon.widget.appBar(context, title: "Forgot Password"),
      body: Container(),
    );
  }
}
