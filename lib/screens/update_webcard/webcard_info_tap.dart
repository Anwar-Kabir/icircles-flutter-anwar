import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  String designation = "";
  String address = "";
  String phone = "";
  String mobile = "";
  String web = "";
  String company = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:
              BoxDecoration(image: AppCon.widget.appBackground(context)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  textField(
                    context,
                    hintText: "Email",
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Name",
                    onSaved: (value) {
                      name = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Designation",
                    onSaved: (value) {
                      designation = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Address",
                    maxLines: null,
                    onSaved: (value) {
                      phone = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Phone",
                    onSaved: (value) {
                      mobile = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Mobile",
                    onSaved: (value) {
                      web = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Web",
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  textField(
                    context,
                    hintText: "Company",
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (value, hintText) {
                      if (value == "") {
                        return '$hintText can\'t be empty!';
                      }
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Company Logo",
                    style: TextStyle(color: AppCon.color.textColor3),
                  ),
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
                              "Choose file",
                              textAlign: TextAlign.center,
                              maxFontSize: 20,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.43),
                                height:
                                    MediaQuery.of(context).size.height * 0.002,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  AppCon.widget.primaryButton(context, text: "Upload"),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  textField(BuildContext context,
      {@required hintText,
      @required onSaved,
      @required validator,
      obsecureText = false,
      maxLines = 3}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: AppCon.color.inputFieldBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            obscureText: obsecureText,
            onSaved: onSaved,
            validator: (value) {
              return validator(value, hintText);
            },
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: TextStyle(
                color: Colors.white.withOpacity(
                  0.42,
                ),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
