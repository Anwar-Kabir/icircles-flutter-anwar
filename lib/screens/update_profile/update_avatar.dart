import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UpdateAvatar extends StatefulWidget {
  const UpdateAvatar({Key? key}) : super(key: key);

  @override
  State<UpdateAvatar> createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  final UserController _userController = Get.find();

  final ImagePicker _picker = ImagePicker();

  XFile? photo;

  _asyncFileUpload(path) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppCon.api.avatarUpdate),
    );
    //add text fields
    request.fields['token'] = _userController.token;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    // ignore: avoid_print
    var responseJson = jsonDecode(responseString);
    _userController.updateAvatar(responseJson['image_url']);
    Get.back();
  }

  changeAvatar(context) {
    AppCon.widget.popUp(
      context,
      text: "Select your image source",
      barrierDismissible: true,
      cancelButtonText: "Camera",
      onCancelButtonTap: () async {
        // ignore: unused_local_variable
        try {
          final pickedFile = await _picker.pickImage(
            source: ImageSource.camera,
            maxHeight: 400,
            maxWidth: 400,
          );
          setState(() {
            photo = pickedFile;
          });
        } catch (e) {
          // error
        }
      },
      onOkButtonTap: () async {
        // ignore: unused_local_variable
        try {
          final pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
            maxHeight: 200,
            maxWidth: 200,
          );
          setState(() {
            photo = pickedFile;
          });

          Get.back();
          AppCon.widget.popUp(
            context,
            text: "",
            barrierDismissible: true,
            widget: Image.file(
              File(photo!.path),
              fit: BoxFit.contain,
            ),
            okButtonText: "Save",
            onOkButtonTap: () {
              Get.back();
              AppCon.widget.loadingOverlay();
              _asyncFileUpload(photo?.path);
            },
          );
        } catch (e) {
          // error
        }
      },
      okButtonText: "Gallery",
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeAvatar(
          context,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.2,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppCon.color.textColor1,
            width: 2,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Obx(
              () => CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: AppCon.api.baseUrl +
                    'uploads/' +
                    _userController.avatar.value,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height * 0.07,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
