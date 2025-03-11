import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practice/screens/login/login.dart';
import 'package:firebase_auth_practice/screens/posts/posts_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsScreen(),
              ));
        },
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        },
      );
    }
  }
}
