import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

socialLogin(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Hero(
        tag: "facebook_login",
        child: Image.asset(
          AppCon.image.facebookIcon,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.04,
      ),
      Hero(
        tag: "gmail_login",
        child: Image.asset(
          AppCon.image.gmailIcon,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.04,
      ),
      Hero(
        tag: "twitter_login",
        child: Image.asset(
          AppCon.image.twitterIcon,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ),
    ],
  );
}
