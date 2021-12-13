import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:icircles/screens/splash_screen.dart';
import 'package:icircles/screens/update_profile/update_profile_screen.dart';
import 'package:icircles/screens/update_webcard/update_webcard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'iCircles',
      home: UpdateWebcardScreen(),
      defaultTransition: Transition.fadeIn,
    );
  }
}
