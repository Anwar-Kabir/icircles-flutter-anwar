const _baseUrl = "http://103.87.139.94/icircles/";

String formatUrl(endpoint) {
  return _baseUrl + endpoint;
}

class AppApiEndpoints {
  final baseUrl = _baseUrl;
  // =================  Login registration related apis  =================
  /// Parameters: email,pass Method: post
  final login = formatUrl("api/login");

  /// Parameters: firstname,lastname,username,email,password,password2 Method: Post
  final register = formatUrl("api/register");

  // =================  User  =========================
  final profile = formatUrl("api/profile"); // parameters: token
  /// Parameters: token, resume (file), Method: Post
  final resumeUpdate = formatUrl("api/profile/resume_update");

  /// Parameters: token, image (file), Method: Post
  final avatarUpdate = formatUrl("api/profile/imgupdateav");

  /// Parameters: token, update_id (info, social, general)
  final updateProfile = formatUrl("api/profile/update");

  // ================= Video related apis ===============
  // Parameters: limit (optional),start (optional), Method: Post
  final fetchVideo = formatUrl("api/users/fetchvideo");
}
