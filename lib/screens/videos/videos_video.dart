import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icircles/models/video_model.dart';
import 'package:video_player/video_player.dart';

class VideosVideo extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final VideoModel videoData;
  const VideosVideo({Key? key, required this.videoData}) : super(key: key);

  @override
  State<VideosVideo> createState() => _VideosVideoState();
}

class _VideosVideoState extends State<VideosVideo> {
  IconData _controlToastIcon = Icons.play_arrow;
  int time = 0;
  double videoSpeed = 1;
  double controlToastOpacity = 0;
  bool favourite = false;
  @override
  void initState() {
    if (!widget.videoData.videoPlayerController.value.isInitialized) {
      widget.videoData.videoPlayerController.initialize().then((_) {
        setState(() {
          widget.videoData.videoPlayerController.play();
          widget.videoData.videoPlayerController.setLooping(true);
        });
      });
    } else {
      setState(() {
        widget.videoData.videoPlayerController.play();
        widget.videoData.videoPlayerController.setLooping(true);
      });
    }
    widget.videoData.videoPlayerController.addListener(() {
      if (widget.videoData.videoPlayerController.value.isPlaying) {
        setState(() {
          time =
              widget.videoData.videoPlayerController.value.position.inSeconds;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.videoData.videoPlayerController.value.isPlaying) {
      widget.videoData.videoPlayerController.pause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: Center(
          // time and seekbar stack
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              //overlaybuttons stack
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // Tap overlays
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      // media control toast
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          // Video container
                          Container(
                            color: Colors.black,
                            child: widget.videoData.videoPlayerController.value
                                    .isInitialized
                                ? AspectRatio(
                                    aspectRatio: widget
                                        .videoData
                                        .videoPlayerController
                                        .value
                                        .aspectRatio,
                                    child: VideoPlayer(
                                        widget.videoData.videoPlayerController),
                                  )
                                : Container(
                                    color: Colors.black,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                          ),
                          Opacity(
                            opacity: controlToastOpacity,
                            child: Icon(
                              _controlToastIcon,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.4,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showControlToast(context);
                                _controlToastIcon = widget.videoData
                                        .videoPlayerController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow;
                                widget.videoData.videoPlayerController.value
                                        .isPlaying
                                    ? widget.videoData.videoPlayerController
                                        .pause()
                                    : widget.videoData.videoPlayerController
                                        .play();
                              });
                            },
                            onDoubleTap: () {
                              // 5 seconds rewind
                              if (time >= 5) {
                                widget.videoData.videoPlayerController
                                    .seekTo(Duration(seconds: time - 5));
                              } else {
                                widget.videoData.videoPlayerController
                                    .seekTo(const Duration(seconds: 0));
                              }
                              showControlToast(context);
                              setState(() {
                                _controlToastIcon = Icons.fast_rewind;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showControlToast(context);
                              setState(() {
                                _controlToastIcon = widget.videoData
                                        .videoPlayerController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow;
                                widget.videoData.videoPlayerController.value
                                        .isPlaying
                                    ? widget.videoData.videoPlayerController
                                        .pause()
                                    : widget.videoData.videoPlayerController
                                        .play();
                              });
                            },
                            onDoubleTap: () {
                              // 5 seconds forward
                              if (time <=
                                  widget.videoData.videoPlayerController.value
                                          .duration.inSeconds -
                                      5) {
                                widget.videoData.videoPlayerController
                                    .seekTo(Duration(seconds: time + 5));
                              } else {
                                widget.videoData.videoPlayerController.seekTo(
                                    Duration(
                                        seconds: widget
                                            .videoData
                                            .videoPlayerController
                                            .value
                                            .duration
                                            .inSeconds));
                              }
                              showControlToast(context);
                              setState(() {
                                _controlToastIcon = Icons.fast_forward;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  overlayButtons(context),
                ],
              ),
              videoControl(context, widget.videoData.videoPlayerController),
            ],
          ),
        ),
      ),
    );
  }

  Widget videoControl(BuildContext context, VideoPlayerController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.videoData.description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.videoData.videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "${convertTime(time)} / ${convertTime(widget.videoData.videoPlayerController.value.duration.inSeconds)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    videoSpeed = videoSpeed < 1.5 ? videoSpeed + 0.5 : 0.5;
                    widget.videoData.videoPlayerController
                        .setPlaybackSpeed(videoSpeed);
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    "${videoSpeed}x".toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                color: Colors.blue[100],
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                height: MediaQuery.of(context).size.height * 0.004,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.blue,
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                height: MediaQuery.of(context).size.height * 0.004,
                width: (MediaQuery.of(context).size.width) *
                    ((widget.videoData.videoPlayerController.value.isInitialized
                        ? time /
                            widget.videoData.videoPlayerController.value
                                .duration.inSeconds
                        : 0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  overlayButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        favourite = !favourite;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.favorite,
                        color: favourite ? Colors.red : Colors.amber,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Icon(
                    Icons.feedback,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Icon(
                    Icons.share,
                    color: Colors.amber,
                  ),
                ],
              ),
              // Avatar and username stack
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.height * 0.07,
                      imageUrl: widget.videoData.userAvatar,
                      placeholder: (context, url) => CircleAvatar(
                        backgroundColor: Colors.blue,
                        maxRadius: MediaQuery.of(context).size.height * 0.025,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        child: const Icon(Icons.error),
                        backgroundColor: Colors.blue,
                        maxRadius: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "@${widget.videoData.username}".toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Icon(
                Icons.home,
                color: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Icon(
                Icons.message,
                color: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Icon(
                Icons.add_circle_outline,
                color: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Icon(
                Icons.notifications,
                color: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showControlToast(BuildContext context) {
    setState(() {
      controlToastOpacity = 0.4;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        controlToastOpacity = 0.0;
      });
    });
  }

  String convertTime(seconds) {
    num t = 0;
    num s = 0;
    if (seconds <= 60) {
      return "0:$seconds";
    } else {
      s = seconds % 60;
      t = (seconds - s) / 60;
      return "${t.toInt()}:${s.toInt()}";
    }
  }
}
