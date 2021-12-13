// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:icircles/getx/video_controller.dart';
import 'package:icircles/screens/update_profile/update_profile_screen.dart';
import 'package:icircles/screens/update_webcard/update_webcard_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:web_browser_detect/web_browser_detect.dart';
import 'package:flutter/material.dart';
import 'package:icircles/screens/login_registration/login_registration_dialog.dart';
import 'package:icircles/screens/videos/videos_video.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideosScreenState();
  }
}

class _VideosScreenState extends State<VideosScreen> {
  bool isLoadingVideos = false;
  int currentIndex = 0;
  final browser = Browser.detectOrNull();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final VideoController _videoController = Get.find();
  final UserController _userController = Get.find();

  @override
  void initState() {
    onPageChangedHandler(0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _key,
        drawer: leftDrawer(),
        endDrawer: rightDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: AppCon.widget.appBackground(context),
          ),
          child: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: isLoadingVideos
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : PageView.builder(
                            onPageChanged: onPageChangedHandler,
                            itemCount: _videoController.videos.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return _videoController.videos.length - 1 < index
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    )
                                  : Obx(
                                      () => VideosVideo(
                                        videoData:
                                            _videoController.videos[index],
                                      ),
                                    );
                            },
                          ),
                  ),
                  _appBar(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget leftDrawer() {
    return Drawer(
      child: Container(
        color: Colors.transparent,
        child: ListView(
          children: [
            ListTile(
              title: const Text('WebCard'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('My Page'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Lounge'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Media'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Inbox'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Video Conference'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget rightDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white54,
        child: Container(
          decoration: BoxDecoration(),
          child: ListView(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "https://icircles.app/uploads/" +
                                _userController.profileHeader.value,
                          ),
                          fit: BoxFit.fitWidth),
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        color: Colors.white,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: AppCon.api.baseUrl +
                              'uploads/' +
                              _userController.avatar.value,
                          placeholder: (context, url) => Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(AppCon.image.loginAvatar),
                              CircularProgressIndicator(),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppCon.image.loginAvatar),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                leading: Icon(Icons.person),
                title: Obx(() => Text(_userController.username.value)),
                children: [
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Icon(Icons.edit),
                    ),
                    title: Text(AppCon.string.updateProfile.getString()),
                    onTap: () {
                      Get.back();
                      Get.to(UpdateProfileScreen());
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Icon(Icons.ac_unit),
                    ),
                    title: Text(
                      AppCon.string.updateWebcard.getString(),
                    ),
                    onTap: () {
                      Get.back();
                      Get.to(UpdateWebcardScreen());
                    },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Icon(Icons.logout),
                    ),
                    title: const Text("Logout"),
                    onTap: () {
                      _userController.logout();
                      Get.back();
                    },
                  ),
                ],
              ),
              ListTile(
                title: const Text("Lounge"),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Config"),
                onTap: () {
                  Get.back();
                  Get.to(UpdateProfileScreen(
                    selectedMenu: 4,
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPageChangedHandler(int value) {
    currentIndex = value;
    var nextIndex = currentIndex + 1;
    VideoPlayerController con =
        _videoController.videos[nextIndex].videoPlayerController;
    if (_videoController.videos.length - 1 >= nextIndex &&
        !con.value.isInitialized) {
      con.initialize();
    }
  }

  Widget _appBar(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menuBurger(
                  context,
                  icon: Icons.menu,
                  onTap: () {
                    _key.currentState!.openDrawer();
                  },
                ),
                _menuBurger(
                  context,
                  icon: Icons.person,
                  onTap: () {
                    VideoPlayerController tempCon = _videoController
                        .videos[currentIndex].videoPlayerController;
                    if (tempCon.value.isPlaying) {
                      tempCon.pause();
                    }
                    if (_userController.isLoggedIn.isTrue) {
                      _key.currentState!.openEndDrawer();
                    } else {
                      _loginRegistrationDialog(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          AppCon.image.logo,
          height: MediaQuery.of(context).size.height * 0.08,
        ),
      ],
    );
  }

  Widget _menuBurger(BuildContext context, {@required onTap, @required icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

_loginRegistrationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginRegistrationDialog();
    },
  );
}
