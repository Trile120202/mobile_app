import 'package:flutter/material.dart';
import 'package:pet_gear_pro/models/auth/login_model.dart';
import 'package:pet_gear_pro/models/auth/signup_model.dart';
import 'package:pet_gear_pro/models/auth_response/profile_model.dart';
import 'package:pet_gear_pro/services/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;
  set isObsecure(bool obsecure) {
    _isObsecure = obsecure;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

  bool _loginResponseBool = false;
  bool get loginResponseBool => _loginResponseBool;
  set loginResponseBool(bool newValue) {
    _loginResponseBool = newValue;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newValue) {
    _loggedIn = newValue;
    notifyListeners();
  }

  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newValue) {
    _responseBool = newValue;
    notifyListeners();
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove("loggedIn");
    loggedIn = prefs.getBool("loggedIn") ?? false;
  }

  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    processing = true;
    bool response = await AuthHelper.login(model);
    processing = false;
    loginResponseBool = response;
    loggedIn = prefs.getBool("loggedIn") ?? false;
    return loginResponseBool;
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("loggedIn") ?? false;
  }

  Future<bool> registerUser(SignupModel model) async {
    responseBool = await AuthHelper.signup(model);
    return responseBool;
  }

  Future<ProfileRes> getUser() async {
    var profile = AuthHelper.getProfile();
    return profile;
  }
}
