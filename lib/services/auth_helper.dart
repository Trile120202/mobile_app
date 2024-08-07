import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_gear_pro/models/auth/login_model.dart';
import 'package:pet_gear_pro/models/auth/profile_update_model.dart';
import 'package:pet_gear_pro/models/auth/signup_model.dart';
import 'package:pet_gear_pro/models/auth_response/login_res_model.dart';
import 'package:pet_gear_pro/models/auth_response/profile_model.dart';
import 'package:pet_gear_pro/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  // LOGIN HELPER
  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('https://${Config.apiUrl}${Config.loginUrl}');
    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    print('Request: ${jsonEncode(model.toJson())}');
    print('Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseData = loginResponseModelFromJson(response.body);
      String userToken = responseData.token;

      await prefs.setString('token', userToken);

      await prefs.setBool('loggedIn', true);

      return true;
    } else {
      print('Failed to login: ${response.body}');
      return false;
    }
  }

  // SIGN UP HELPER
  static Future<bool> signup(SignupModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('https://${Config.apiUrl}${Config.signupUrl}');
    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    print('Request: ${jsonEncode(model.toJson())}');
    print('Response: ${response.statusCode} ${response.body}');

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Failed to signup: ${response.body}');
      return false;
    }
  }

  static Future<bool> updateUserProfile(Map<String, String> profile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse('https://${Config.apiUrl}${Config.updateprofile}');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(profile),
    );

    if (response.statusCode == 200||response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

//Get User infor
  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse('https://${Config.apiUrl}${Config.profile}');
    print('Get Profile URL: $url');
    print('Token: $token');

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      // print('--------------${response.body}');
      var profile = profileResFromJson(response.body);
      print('Parsed Profile: ${profile.toJson()}');
      return profile;
    } else {
      throw Exception('Failed to get a profile');
    }
  }
}
