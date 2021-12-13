import 'package:get/get.dart';
// import 'package:icircles/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  String token = "";
  // Rx<ProfileModel> profile = ProfileModel().obs;

  RxString id = "".obs;
  RxString username = "".obs;
  RxString firstname = "".obs;
  RxString lastname = "".obs;
  RxString email = "".obs;
  RxString qrUrl = "".obs;
  RxString phone = "".obs;
  RxString image = "".obs;
  RxString thumb = "".obs;
  RxString designation = "".obs;
  RxString aboutMe = "".obs;
  RxString country = "".obs;
  RxString city = "".obs;
  RxString address = "".obs;
  RxString mobile = "".obs;
  RxString website = "".obs;
  RxString skype = "".obs;
  RxString whatsapp = "".obs;
  RxString facebook = "".obs;
  RxString twitter = "".obs;
  RxString linkedin = "".obs;
  RxString instagram = "".obs;
  RxString resume = "".obs;
  RxString createdDate = "".obs;
  RxString updatedDate = "".obs;
  RxString avatar = "".obs;
  RxString joined = "".obs;
  RxString joinedDate = "".obs;
  RxString onlineTimestamp = "".obs;
  RxString profileViews = "".obs;
  RxString profileComments = "".obs;
  RxString profileHeader = "".obs;
  RxString locationFrom = "".obs;
  RxString friends = "".obs;
  RxString pages = "".obs;

  setLoginData(response, tkn, {remember = true}) async {
    isLoggedIn = true.obs;
    token = tkn;
    setProfileData(response['profile']);
    if (remember) {
      saveTokenToLocalStorage(token);
    }
  }

  setProfileData(Map<String, dynamic> json) {
    // profile.value = ProfileModel.fromJson(json);
    id.value = json['id'];
    username.value = json['username'];
    firstname.value = json['firstname'];
    lastname.value = json['lastname'];
    email.value = json['email'];
    qrUrl.value = json['qr_url'];
    phone.value = json['phone'];
    image.value = json['image'];
    thumb.value = json['thumb'];
    designation.value = json['designation'];
    aboutMe.value = json['about_me'];
    country.value = json['country'];
    city.value = json['city'];
    address.value = json['address'];
    mobile.value = json['mobile'];
    website.value = json['web_site'];
    skype.value = json['skype'];
    whatsapp.value = json['whatsapp'];
    facebook.value = json['facebook'];
    twitter.value = json['twitter'];
    linkedin.value = json['linkedin'];
    instagram.value = json['instagram'];
    resume.value = json['resume'];
    createdDate.value = json['created_date'];
    updatedDate.value = json['updated_date'];
    avatar.value = json['avatar'];
    joined.value = json['joined'];
    joinedDate.value = json['joined_date'];
    onlineTimestamp.value = json['online_timestamp'];
    profileViews.value = json['profile_views'];
    profileComments.value = json['profile_comments'];
    profileHeader.value = json['profile_header'];
    locationFrom.value = json['location_from'];
    friends.value = json['friends'];
    pages.value = json['pages'];
    update();
  }

  updateAvatar(url) {
    avatar.value = url;
    update();
  }

  updateResume(url) {
    resume.value = url;
    update();
  }

  saveTokenToLocalStorage(token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("token", token);
  }

  logout() async {
    isLoggedIn = false.obs;
    token = "";
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("token", "");
  }
}
