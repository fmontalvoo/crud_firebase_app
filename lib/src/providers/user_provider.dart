import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:crud_firebase_app/src/utils/keys/keys.dart';
import 'package:crud_firebase_app/src/preferences/user_preferences.dart';

class UserProvider {
  final String _firebaseToken = FIREBASE_KEY;
  final _prefs = UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final user = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };
    final response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(user));

    Map<String, dynamic> decode = json.decode(response.body);

    if (decode.containsKey('idToken')) {
      _prefs.setToken = decode['idToken'];
      return {"success": true};
    } else {
      return {"success": false};
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final user = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(user));

    Map<String, dynamic> decode = json.decode(response.body);

    if (decode.containsKey('idToken')) {
      _prefs.setToken = decode['idToken'];
      return {"success": true};
    } else {
      return {"success": false};
    }
  }
}
