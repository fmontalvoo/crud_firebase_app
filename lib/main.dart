import 'package:flutter/material.dart';
import 'package:crud_firebase_app/src/bloc/provider.dart';

import 'package:crud_firebase_app/src/pages/login_page.dart';
import 'package:crud_firebase_app/src/pages/register_page.dart';
import 'package:crud_firebase_app/src/pages/home_page.dart';
import 'package:crud_firebase_app/src/pages/product_page.dart';
import 'package:crud_firebase_app/src/preferences/user_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = UserPreferences();
  await _prefs.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'C.R.U.D Firebase',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'login',
        routes: {
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
          'home': (context) => HomePage(),
          'product': (context) => ProductPage(),
        },
      ),
    );
  }
}
