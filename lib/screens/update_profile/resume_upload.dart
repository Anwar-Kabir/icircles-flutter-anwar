import 'dart:convert';
// import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ResumeUpload extends StatelessWidget {
  ResumeUpload({Key? key}) : super(key: key);
  final UserController _userController = Get.find();

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // ignore: unused_local_variable
      // File file = File(result.files.single.path!);
      AppCon.widget.loadingOverlay();
      _asyncFileUpload(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  _asyncFileUpload(path) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppCon.api.resumeUpdate),
    );
    //add text fields
    request.fields['token'] = _userController.token;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("resume", path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    // ignore: avoid_print
    var responseJson = jsonDecode(responseString);
    _userController.updateResume(responseJson['resume_url']);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Resume:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppCon.color.textColor1,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        dividerLine(context),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.005,
          ),
          decoration: BoxDecoration(
            color: AppCon.color.inputFieldBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      ".." +
                          _userController.resume.value.substring(
                              _userController.resume.value.length ~/ 1.5,
                              _userController.resume.value.length),
                      textAlign: TextAlign.left,
                      maxFontSize: 16,
                      minFontSize: 6,
                      style: TextStyle(
                        color: AppCon.color.textColor3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppCon.widget.launchURL(
                          url:
                              AppCon.api.baseUrl + _userController.resume.value,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: MediaQuery.of(context).size.height * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: AppCon.color.textColor1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: AppCon.color.textColor1,
                          ),
                        ),
                        child: const AutoSizeText(
                          "Download",
                          minFontSize: 6,
                          maxFontSize: 16,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  pickFile();
                },
                child: Container(
                  color: Colors.transparent,
                  child: DottedBorder(
                    dashPattern: const [6, 3, 2, 3],
                    color: AppCon.color.textColor1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload,
                                color: const Color.fromRGBO(70, 213, 236, 1),
                                size: MediaQuery.of(context).size.height * 0.1,
                              ),
                              AutoSizeText(
                                "Select new resumme (pdf/docx)",
                                maxFontSize: 20,
                                style: TextStyle(
                                  color: AppCon.color.textColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  dividerLine(context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
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
}
