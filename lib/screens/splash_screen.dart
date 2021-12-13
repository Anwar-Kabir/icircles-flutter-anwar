import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:icircles/getx/video_controller.dart';
import 'package:icircles/screens/videos/videos_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VideoController _videoController = Get.put(VideoController());
  final UserController _userController = Get.put(UserController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    _videoController.loadVideos(() {
      // Get.offAll(const ICircles());
      checkToken();
    });
    super.initState();
  }

  checkToken() async {
    String token = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? "";
    });
    if (token != "") {
      http.post(Uri.parse(AppCon.api.profile), body: {"token": token}).then(
          (value) {
        var response = jsonDecode(value.body);
        if (response['status']) {
          _userController.setLoginData(response, token, remember: true);
          Get.offAll(const VideosScreen());
        }
      });
    } else {
      Get.offAll(const VideosScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppCon.image.background,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Image.asset(AppCon.image.logo),
        ),
      ),
    );
  }
}
