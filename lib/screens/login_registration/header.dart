import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

class LoginRegisterHeader extends StatelessWidget {
  const LoginRegisterHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: AppCon.color.textColor1,
        ),
      )),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
          ),
          Hero(
            tag: "logo",
            child: Image.asset(
              AppCon.image.logo,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          )
        ],
      ),
    );
  }
}
