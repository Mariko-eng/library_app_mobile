import 'dart:async';
import 'dart:convert';
import 'package:attendx/constants/api_constants.dart';
import 'package:attendx/models/auth_user_model.dart';
import 'package:attendx/views/auth/auth_wapper_view.dart';
import 'package:get/get.dart' as Getx;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AuthController() {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();
    _refreshUserTokens();
  }

  Future<bool> _refreshUserTokens() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("refresh_token") ?? "";

      if (token != "") {
        Dio dio = Dio();
        var postData = {
          "refresh": token
        };

        String endpoint = ApiConstants.api_endpont;
        Response response1 =
            await dio.post("${endpoint}users/token/refresh/",
              data: postData,
            );

        Map resp = response1.data as Map;
        String accessToken = resp["access_token"]["token"];
        String refreshToken = resp["refresh_token"]["token"];

        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);

        Dio dio2 = Dio();
        dio2.options.headers['Authorization'] = 'Bearer $accessToken';
        Response response2 =
        await dio2.get("${endpoint}users/get-logged-in-user/",
          data: postData,
        );
        Map<String, dynamic> userMap = response2.data as Map<String, dynamic>;
        await prefs.setString('userData', jsonEncode(userMap));
        _userModel = UserModel.fromJson(userMap);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> primaryLogin(
      {required String email, required String password}) async {
    try {
      _isLoading = true;
      _userModel = null;
      notifyListeners();

      String endpoint = ApiConstants.api_endpont;

      var postData = {
        "email": email,
        "password": password,
      };

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      print( "${endpoint}users/token/login/");

      Response response = await dio.post(
        "${endpoint}users/token/login/",
        data: postData,
      );

      // print(response.data);
      Map resp = response.data as Map;
      String accessToken = resp["access_token"]["token"];
      String refreshToken = resp["refresh_token"]["token"];
      Map<String, dynamic> userMap = resp['user'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', email);
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setString('userData', jsonEncode(userMap));

      _userModel = UserModel.fromJson(userMap);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      Getx.Get.snackbar(
          "Something Went Wrong!", "Please Provide Valid Login Credentials",
          colorText: Colors.white, backgroundColor: Colors.red);
      _userModel = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      _userModel = null;
      _isLoading = false;
      notifyListeners();
      Getx.Get.to(() => const AuthWrapperView());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
