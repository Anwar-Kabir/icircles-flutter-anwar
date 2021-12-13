import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/getx/user_controller.dart';
import 'package:icircles/screens/update_profile/resume_upload.dart';
import 'package:icircles/screens/update_profile/update_avatar.dart';
import 'package:http/http.dart' as http;

class UpdateProfileInfo extends StatefulWidget {
  const UpdateProfileInfo({Key? key}) : super(key: key);

  @override
  State<UpdateProfileInfo> createState() => _UpdateProfileInfoState();
}

class _UpdateProfileInfoState extends State<UpdateProfileInfo> {
  final _infoFormKey = GlobalKey<FormState>();
  final UserController _userController = Get.find();
  var countries = [];

  String firstname = "";
  String lastname = "";
  String designation = "";
  String email = "";
  Map<String, String> selectedCountry = {
    "id": "",
    "name": "",
  };
  String mobile = "";
  String web = "";
  String aboutMe = "";

  saveInfoChanges(BuildContext context) {
    AppCon.widget.loadingOverlay();
    http.post(Uri.parse(AppCon.api.updateProfile), body: {
      "token": _userController.token,
      "update_id": "info",
    }).then((value) {
      var response = jsonDecode(value.body);
      // ignore: avoid_print
      print(response);
      Future.delayed(const Duration(seconds: 4), () {
        Get.back();
        Get.snackbar(
          "Success",
          "Your information has updated!",
          backgroundColor: Colors.green[100],
        );
      });
    }).onError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong, try again!",
        backgroundColor: Colors.green[100],
      );
    });
  }

  loadCountries() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("resources/json/countries.json");
    setState(() {
      countries = jsonDecode(data);
      selectedCountry = getCountry(_userController.country.value);
    });
  }

  Map<String, String> getCountry(String id) {
    for (var country in countries) {
      if (country['id'] == id) {
        return {"id": country['id'], "name": country["name"]};
      }
    }
    return {"id": "", "name": ""};
  }

  selectCountry(country) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCountry = {
            "id": country['id'],
            "name": country['name'],
          };
        });
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        color: Colors.transparent,
        child: Text(
          country["name"]!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppCon.color.textColor3,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  countrySelectDialog(BuildContext context) {
    bool barrierDismissible = true;

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      builder: (context) {
        String countrySearchQuery = "";
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async {
              return barrierDismissible;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(15, 14, 14, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: AppCon.color.textColor1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.06,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: AppCon.color.inputFieldBackground,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            onChanged: (String value) {
                              setState(() {
                                countrySearchQuery = value;
                              });
                            },
                            style: TextStyle(color: AppCon.color.textColor3),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                color: AppCon.color.textColor3,
                              ),
                              label: const Text("Search"),
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.43),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.06,
                            vertical:
                                MediaQuery.of(context).size.height * 0.002,
                          ),
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (countrySearchQuery != "") {
                                if (countries[index]["name"]!
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        countrySearchQuery.toLowerCase())) {
                                  return selectCountry(countries[index]);
                                } else {
                                  return Container();
                                }
                              } else {
                                return selectCountry(countries[index]);
                              }
                            },
                            separatorBuilder: (context, index) {
                              if (countrySearchQuery != "") {
                                if (countries[index]["name"]!
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        countrySearchQuery.toLowerCase())) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: BorderDirectional(
                                        bottom: BorderSide(
                                          color: AppCon.color.textColor1,
                                          width: 0.7,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container(
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
                            },
                            itemCount: countries.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Widget countryField(BuildContext context, country) {
    return GestureDetector(
      onTap: () {
        countrySelectDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.height * 0.025,
        ),
        decoration: BoxDecoration(
          color: AppCon.color.inputFieldBackground,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCountry["name"]!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppCon.color.textColor3,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Icon(
              Icons.arrow_drop_down_circle,
              color: AppCon.color.textColor3,
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    loadCountries();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
            ),
            child: Form(
              key: _infoFormKey,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Avatar:",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const UpdateAvatar(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Information:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppCon.color.textColor1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      AppCon.widget.primaryButton(
                        context,
                        text: "Save Changes",
                        horizontalPadding:
                            MediaQuery.of(context).size.width * 0.025,
                        verticalPadding:
                            MediaQuery.of(context).size.height * 0.005,
                        onTap: () {
                          saveInfoChanges(context);
                        },
                      ),
                    ],
                  ),
                  dividerLine(context),
                  textField1(context,
                      text: _userController.firstname.value,
                      hintText: "First name",
                      onSaved: () {}),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.lastname.value,
                    hintText: "Last name",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.designation.value,
                    hintText: "Designation",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.email.value,
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  countryField(context, _userController.country.value),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.address.value,
                    hintText: "Address",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.mobile.value,
                    hintText: "Mobile",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(context,
                      text: _userController.website.value, hintText: "Web"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  textField1(
                    context,
                    text: _userController.aboutMe.value,
                    hintText: "About me",
                    maxLines: null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ResumeUpload(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
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

  textField1(context,
      {required text,
      required hintText,
      maxLines = 1,
      enabled = true,
      onSaved}) {
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
        style: TextStyle(color: AppCon.color.textColor3),
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
