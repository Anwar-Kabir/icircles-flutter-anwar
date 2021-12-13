class ProfileModel {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String qrUrl;
  final String phone;
  final String image;
  final String thumb;
  final String designation;
  final String aboutMe;
  final String country;
  final String city;
  final String address;
  final String mobile;
  final String website;
  final String skype;
  final String whatsapp;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String resume;
  final String createdDate;
  final String updatedDate;
  String avatar;
  final String joined;
  final String joinedDate;
  final String onlineTimestamp;
  final String profileViews;
  final String profileComments;
  final String profileHeader;
  final String locationFrom;
  final String friends;
  final String pages;

  ProfileModel({
    this.id = "",
    this.username = "",
    this.firstname = "",
    this.lastname = "",
    this.email = "",
    this.qrUrl = "",
    this.phone = "",
    this.image = "",
    this.thumb = "",
    this.designation = "",
    this.aboutMe = "",
    this.country = "",
    this.city = "",
    this.address = "",
    this.mobile = "",
    this.website = "",
    this.skype = "",
    this.whatsapp = "",
    this.facebook = "",
    this.twitter = "",
    this.linkedin = "",
    this.instagram = "",
    this.resume = "",
    this.createdDate = "",
    this.updatedDate = "",
    this.avatar = "",
    this.joined = "",
    this.joinedDate = "",
    this.onlineTimestamp = "",
    this.profileViews = "",
    this.profileComments = "",
    this.profileHeader = "",
    this.locationFrom = "",
    this.friends = "",
    this.pages = "",
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        email = json['email'],
        qrUrl = json['qr_url'],
        phone = json['phone'],
        image = json['image'],
        thumb = json['thumb'],
        designation = json['designation'],
        aboutMe = json['about_me'],
        country = json['country'],
        city = json['city'],
        address = json['address'],
        mobile = json['mobile'],
        website = json['web_site'],
        skype = json['skype'],
        whatsapp = json['whatsapp'],
        facebook = json['facebook'],
        twitter = json['twitter'],
        linkedin = json['linkedin'],
        instagram = json['instagram'],
        resume = json['resume'],
        createdDate = json['created_date'],
        updatedDate = json['updated_date'],
        avatar = json['avatar'],
        joined = json['joined'],
        joinedDate = json['joined_date'],
        onlineTimestamp = json['online_timestamp'],
        profileViews = json['profile_views'],
        profileComments = json['profile_comments'],
        profileHeader = json['profile_header'],
        locationFrom = json['location_from'],
        friends = json['friends'],
        pages = json['pages'];
}

/*
{
    "id": "103",
    "username": "nishad",
    "firstname": "Foyez Ahmed",
    "lastname": "Nishad",
    "email": "nishad@icircles.app",
    "qr_url": "nishad.png",
    "phone": "",
    "image": "uploads/images/medium/d1b733bf8e27988a841304a24f94c28f_medium.jpg",
    "thumb": "./uploads/images/thumbnail/1031635568686.png",
    "designation": "",
    "about_me": "",
    "country": "2",
    "city": "Uttara",
    "address": "Uttara, Dhaka",
    "mobile": "",
    "web_site": "",
    "skype": "",
    "whatsapp": "",
    "facebook": "beastbengal",
    "twitter": "newnishad",
    "linkedin": "nisadrehman",
    "instagram": "",
    "resume": "uploads/resume/1635678684Invoice-oct-2021.pdf",
    "created_date": "2021-10-20 10:40:11",
    "updated_date": "2021-11-20 11:27:58",
    "avatar": "8ff59c9c997b680c3e93c58ddcc33b83.jpg",
    "joined": "1634726411",
    "joined_date": "10-2021",
    "online_timestamp": "1637407678",
    "profile_views": "86",
    "profile_comments": "0",
    "profile_header": "60499e718f8eb751a27614913d309914.jpg",
    "location_from": "Noakhali, Bangladesh",
    "friends": "a:2:{i:0;s:3:\"104\";i:1;s:3:\"104\";}",
    "pages": ""
  }
*/
