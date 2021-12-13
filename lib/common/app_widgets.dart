import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWidgets {
  final RemoteConfig remoteConfig = RemoteConfig.instance;

  appBackground(context) {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage(
        AppCon.image.background,
      ),
    );
  }

  popUp(
    context, {
    required text,
    required bool barrierDismissible,
    barrierColor,
    okButtonText,
    cancelButtonText,
    onOkButtonTap,
    onCancelButtonTap,
    widget,
  }) {
    List<Widget> _buttons = [];

    if (cancelButtonText != null) {
      _buttons.add(GestureDetector(
        onTap: onCancelButtonTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.004,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppCon.color.textColor1,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            cancelButtonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }
    if (okButtonText != null) {
      _buttons.add(
        GestureDetector(
          onTap: onOkButtonTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.004,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(71, 242, 0, 0.29),
              border: Border.all(
                color: AppCon.color.textColor1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              okButtonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor:
          barrierDismissible ? Colors.black54 : Colors.white.withOpacity(0.3),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(15, 14, 14, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: AppCon.color.textColor1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget ?? Container(),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppCon.color.textColor1,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buttons,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  appBar(context, {required title, onBackPress}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppCon.color.textColor1,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (onBackPress == null) {
                    Get.back();
                  } else {
                    onBackPress();
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppCon.color.textColor1,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget underline(context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: AppCon.color.textColor1,
            width: 0.7,
          ),
        ),
      ),
    );
  }

  loadConfig() async {
    await remoteConfig.fetchAndActivate();
    // ignore: avoid_print
    print(remoteConfig.getString("config"));
    //var config = jsonDecode(remoteConfig.getString('config'));
    // ignore: avoid_print
    //print('App Version: ${config['version']}');
  }

  loadingOverlay() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: Colors.white.withOpacity(0.3),
          child: Center(
            child: Lottie.asset("resources/lottie/animation_loading2.json"),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  errorDialog(onConfirm, {e}) {
    Get.defaultDialog(
      title: "Error",
      middleText: "Something went wrong!\n" + e.toString(),
      textConfirm: "Try again",
      confirmTextColor: Colors.white,
      onConfirm: onConfirm,
      barrierDismissible: false,
      onWillPop: null,
    );
  }

  void launchURL({required url}) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  primaryButton(BuildContext context,
      {text = "", onTap, horizontalPadding, verticalPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:
                  horizontalPadding ?? MediaQuery.of(context).size.width * 0.04,
              vertical:
                  verticalPadding ?? MediaQuery.of(context).size.height * 0.013,
            ),
            decoration: BoxDecoration(
              color: AppCon.color.textColor1.withOpacity(0.2),
              border: Border.all(
                color: AppCon.color.textColor1,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
