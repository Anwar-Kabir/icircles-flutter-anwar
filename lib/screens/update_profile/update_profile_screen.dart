import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/screens/update_profile/update_profile_config.dart';
import 'package:icircles/screens/update_profile/update_profile_info.dart';
import 'package:icircles/screens/update_profile/update_profile_photo.dart';
import 'package:icircles/screens/update_profile/update_profile_social.dart';
import 'package:icircles/screens/update_profile/update_profile_video.dart';

class UpdateProfileScreen extends StatefulWidget {
  final int selectedMenu;
  const UpdateProfileScreen({Key? key, this.selectedMenu = 0})
      : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedMenuId = 0;
  late PageController pageController;

  final List<Widget> _menu = [
    const UpdateProfileInfo(),
    const UpdateProfileSocial(),
    const UpdateProfilePhoto(),
    const UpdateProfileVideo(),
    const UpdateProfileConfig(),
  ];

  @override
  void initState() {
    setState(() {
      pageController = PageController(initialPage: widget.selectedMenu);
      selectedMenuId = widget.selectedMenu;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: AppCon.widget.appBackground(context),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppCon.widget.appBar(
                context,
                title: AppCon.string.updateProfile.getString(),
              ),
              editMenu(context),
              AppCon.widget.underline(context),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  children: _menu,
                  onPageChanged: (index) {
                    setState(() {
                      selectedMenuId = index;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget editMenu(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        menuButton(context, text: "Info", menuId: 0),
        menuButton(context, text: "Social", menuId: 1),
        menuButton(context, text: "Photo", menuId: 2),
        menuButton(context, text: "Video", menuId: 3),
        menuButton(context, text: "Config", menuId: 4),
      ],
    );
  }

  Widget menuButton(context, {required text, required menuId}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenuId = menuId;
          pageController.animateToPage(
            menuId,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: menuId == selectedMenuId
                ? AppCon.color.textColor1
                : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppCon.color.textColor1,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
