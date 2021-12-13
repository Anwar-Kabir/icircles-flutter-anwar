import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

loginRegisterButton(BuildContext context, {@required text, @required onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.07,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppCon.color.textColor1.withOpacity(0.50),
        border: Border.all(
          color: AppCon.color.textColor1,
        ),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
