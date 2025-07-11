class AppUrls {
  static const String baseUrl = 'https://hannanavtor-backend.vercel.app/api/v1';

  static const String webSocket = 'ws://10.0.20.16:4000';

  static const String registerUrl = '$baseUrl/users/create';
  static const String loginUrl = '$baseUrl/auth/login';
  static const String notification = '$baseUrl/notifications';

  static String contactProfileId(String id) =>
      '$baseUrl/connections/contact-profile/$id';
}
