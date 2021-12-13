import 'package:flutter/material.dart';

import '../../app_config.dart';

class Print extends StatelessWidget {
  const Print({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Webcards",
      style: TextStyle(color: AppCon.color.textColor3),
    );
  }
}
