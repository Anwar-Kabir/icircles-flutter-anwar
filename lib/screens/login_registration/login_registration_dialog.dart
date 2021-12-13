import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/screens/login_registration/login_screen.dart';
import 'package:icircles/screens/login_registration/registration_screen.dart';

class LoginRegistrationDialog extends StatelessWidget {
  const LoginRegistrationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.amber,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton(
                  context,
                  onTap: () {
                    Get.back();
                    Get.to(const LoginScreen());
                  },
                  text: "Sign In",
                  color: Colors.blue,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                customButton(
                  context,
                  onTap: () {
                    Get.back();
                    Get.to(const RegisterScreen());
                  },
                  text: "Create Account",
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

customButton(BuildContext context,
    {@required onTap, @required text, @required color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.015,
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      color: color,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
