import 'package:flutter/material.dart';

import '../../app_config.dart';

class Change extends StatelessWidget {
  const Change({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Change",
      style: TextStyle(color: AppCon.color.textColor3),
    );
  }
}
