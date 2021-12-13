import 'package:video_player/video_player.dart';

class VideoModel {
  final String username;
  final String userAvatar;
  final String category;
  final String description;
  final String slug;
  final String metaTag;
  final String uploadDate;
  final String impression;
  final String videoid;
  final String uploadLocation;
  final String originCountry;
  final String videoUrl;
  final String title;
  VideoPlayerController videoPlayerController;

  VideoModel({
    this.username = "",
    this.userAvatar = "",
    this.category = "",
    this.description = "",
    this.slug = "",
    this.metaTag = "",
    this.impression = "",
    this.originCountry = "",
    this.title = "",
    this.uploadDate = "",
    this.uploadLocation = "",
    this.videoUrl = "",
    this.videoid = "",
    required this.videoPlayerController,
  });

  VideoModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        userAvatar = json['useravt'],
        category = json['category'],
        description = json['description'],
        slug = json['slug'],
        metaTag = json['meta_tag'],
        uploadDate = json['upload_date'],
        impression = json['impression'],
        videoid = json['videoid'],
        uploadLocation = json['uload_location'],
        originCountry = json['origine_country'],
        videoUrl = json['videourl'],
        title = json['title'],
        videoPlayerController = VideoPlayerController.network(json['videourl']);
}

/*
{
      "username": "Mahimic_2004",
      "useravt": "https://icircles.app/./uploads/images/thumbnail/1081636984158.png",
      "category": "4",
      "description": "None",
      "slug": "Nono",
      "meta_tag": "",
      "upload_date": "2021-11-15",
      "impression": "0",
      "videoid": "51",
      "uload_location": "",
      "origine_country": "",
      "videourl": "https://icircles.app/uploads/video/iCircles-office-Dhaka1636983542108.mp4",
      "title": "iCircles office ,Dhaka"
    },
*/