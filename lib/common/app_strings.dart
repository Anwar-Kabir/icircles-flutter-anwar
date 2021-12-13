class AppStrings {
  final updateProfile = Languages(
    english: "Update Profile",
  );
  final updateWebcard = Languages(
    english: "Update Webcard",
  );

final addWebcard = Languages(
    english: "Add Webcard",
  );

}

class Languages {
  final String english;
  Languages({required this.english});

  getString() {
    return english;
  }
}
