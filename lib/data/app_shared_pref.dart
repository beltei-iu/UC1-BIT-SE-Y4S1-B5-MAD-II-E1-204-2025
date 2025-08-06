class AppSharedPref {
  static Future<void> login(String email, String password) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString("email", email);
    // prefs.setString("password", password);
  }

  static Future<void> register(
    String fullName,
    String email,
    String password,
  ) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString("fullName", fullName);
    // prefs.setString("email", email);
    // prefs.setString("password", password);
  }

  static Future<void> logout() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
  }
}
