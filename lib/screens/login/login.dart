import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practice/screens/posts/posts_screen.dart';
import 'package:firebase_auth_practice/screens/signup/sign_up.dart';
import 'package:firebase_auth_practice/utils/app_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailContorller = TextEditingController();

  final passwordContorller = TextEditingController();
  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailContorller.dispose();
    passwordContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                controller: emailContorller,
                hintText: 'email',
                enableBorder: true,
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    return null;
                  } else {
                    return "Enter Email";
                  }
                },
              ),
              AppTextField(
                controller: passwordContorller,
                hintText: 'password',
                enableBorder: true,
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    return null;
                  } else {
                    return "Enter Password";
                  }
                },
              ),
              AppButton(
                isLoading: isLoading,
                title: 'Login',
                onPressed: () {
                  _login();
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailContorller.text, password: passwordContorller.text)
          .then(
        (UserCredential userCredential) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Login Successfuly!")));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostsScreen(),
              ));

          setState(() {
            isLoading = false;
          });
        },
      ).onError(
        (error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          String errorMessage = "Something went wrong";
          if (error is FirebaseAuthException) {
            switch (error.code) {
              case 'invalid-credential':
                errorMessage = "Invalid Credentials";
                break;
              default:
                errorMessage;
            }
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        },
      );
    }
  }
}
