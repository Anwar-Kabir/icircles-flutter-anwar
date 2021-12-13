import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/screens/update_webcard/webcard_change_tap.dart';
import 'package:icircles/screens/update_webcard/webcard_info_tap.dart';
import 'package:icircles/screens/update_webcard/webcard_mywebcards_tap.dart';
import 'package:icircles/screens/update_webcard/webcard_print_tap.dart';

class UpdateWebcardScreen extends StatefulWidget {
  final int selectedMenu;
  const UpdateWebcardScreen({Key? key, this.selectedMenu = 0})
      : super(key: key);

  @override
  State<UpdateWebcardScreen> createState() => _UpdateWebcardScreenState();
}

class _UpdateWebcardScreenState extends State<UpdateWebcardScreen> {
  int selectedMenuId = 0;
  late PageController pageController;

  final List<Widget> _menu = [
    MyWebards(),
    const Print(),
    const Change(),
    const Info(),
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


        decoration: BoxDecoration(
          image: AppCon.widget.appBackground(context),
        ),
        child: SafeArea(
          child: Column(children: [
            AppCon.widget.appBar(
              context,
              title: AppCon.string.updateWebcard.getString(),
            ),
            // const WebcardTop(),

            Container(

              height: 550,

              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,  //////-----media query hight issue-----/////
              decoration: BoxDecoration(
                image: AppCon.widget.appBackground(context),
              ),
              child: Column(
                children: [
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
          ]),
        ),
      ),
    );
  }

  Widget editMenu(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        menuButton(context,
            text: " My Webcards",
            imageData: 'resources/images/login_avatar_95x95.png',
            menuId: 0),
        menuButton(context,
            text: " Print",
            imageData: 'resources/images/login_avatar_95x95.png',
            menuId: 1),
        menuButton(context,
            text: " Change",
            imageData: 'resources/images/login_avatar_95x95.png',
            menuId: 2),
        menuButton(context,
            text: " Info",
            imageData: 'resources/images/login_avatar_95x95.png',
            menuId: 3),
      ],
    );
  }

  Widget menuButton(
    context, {
    required text,
    required menuId,
    required imageData,
  }) {
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
          child: Row(
            children: [
              Image.asset(
                '${imageData}',
                height: 20,
                width: 20,

                //color: AppCon.color.textColor1,
              ),
              Text(
                text,
                style: TextStyle(
                  color: AppCon.color.textColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          )),
    );
  }
}
