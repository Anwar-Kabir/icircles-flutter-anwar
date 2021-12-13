import 'package:flutter/material.dart';
import '../../app_config.dart';

class AddWebcard extends StatelessWidget {
  const AddWebcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: AppCon.widget.appBackground(context),
        ),
        child: SafeArea(
          child: Column(children: [
            AppCon.widget.appBar(
              context,
              title: AppCon.string.addWebcard.getString(),
            ),
          ]),
        ),
      ),
    ));
  }
}
