import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

class UpdateProfilePhoto extends StatelessWidget {
  const UpdateProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Column(
        children: [
          DottedBorder(
            dashPattern: const [6, 3, 2, 3],
            color: AppCon.color.textColor1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      color: const Color.fromRGBO(70, 213, 236, 1),
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    AutoSizeText(
                      "Upload\nChoose file",
                      textAlign: TextAlign.center,
                      maxFontSize: 20,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.43),
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          AppCon.widget.primaryButton(context, text: "Upload"),
        ],
      ),
    );
  }
}
