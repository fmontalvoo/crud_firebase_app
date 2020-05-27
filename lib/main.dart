import 'package:flutter/material.dart';
import 'package:crud_firebase_app/src/bloc/provider.dart';

import 'package:crud_firebase_app/src/pages/home_page.dart';
import 'package:crud_firebase_app/src/pages/login_page.dart';
import 'package:crud_firebase_app/src/pages/product_page.dart';

void main() {
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
        initialRoute: 'home',
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'product': (context) => ProductPage(),
        },
      ),
    );
  }
}
