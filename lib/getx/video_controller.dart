import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icircles/app_config.dart';
import 'package:icircles/models/video_model.dart';

class VideoController extends GetxController {
  RxList<dynamic> videos = [].obs;

  void loadVideos(callback) {
    http.get(Uri.parse(AppCon.api.fetchVideo)).then(
      (value) {
        var response = jsonDecode(value.body);
        response['data'].forEach((element){
          videos.add(VideoModel.fromJson(element));
        });
        callback();
      },
    ).catchError((error) {
      AppCon.widget.errorDialog(() {
        Get.back();
        loadVideos(callback);
      }, e: error);
    });
  }
}
