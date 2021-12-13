import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';

class UpdateProfileSocial extends StatelessWidget {
  const UpdateProfileSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      child: Column(
        children: [
          textField1(context, text: "", hintText: "Facebook profile URL"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          textField1(context, text: "", hintText: "LinkedIn profile URL"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          textField1(context, text: "", hintText: "Twitter profile URL"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          textField1(context, text: "", hintText: "Instagram profile URL"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          AppCon.widget.primaryButton(context, text: "Update", onTap: () {
            AppCon.widget.popUp(context,
                text:
                    "You have made changes to your information.\nDo you wanna save?",
                barrierDismissible: true,
                okButtonText: "Save",
                cancelButtonText: "Cancel", onCancelButtonTap: () {
              Get.back();
            });
          }),
        ],
      ),
    );
  }

  textField1(context,
      {required text, required hintText, maxLines = 1, enabled = true}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: AppCon.color.inputFieldBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        enabled: enabled,
        initialValue: text,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
          label: Text(hintText),
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.43),
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
