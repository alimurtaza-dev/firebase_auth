import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practice/utils/app_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _signUpKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _signUpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                controller: emailController,
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
                controller: passwordController,
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
                title: 'Sign Up',
                onPressed: () {
                  _registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() {
    if (_signUpKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
        (UserCredential userCredential) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration Successful!")));
          setState(() {
            isLoading = false;
          });
        },
      ).onError(
        (error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          String errorMessage =
              "An unexpected error occurred. Please try again.";

          if (error is FirebaseAuthException) {
            switch (error.code) {
              case "email-already-in-use":
                errorMessage = "User already exists";
              case 'invalid-email':
                errorMessage = "The email address is not valid.";
                break;
              case 'weak-password':
                errorMessage = "The password is too weak.";
                break;
              case 'operation-not-allowed':
                errorMessage = "Email/password accounts are disabled.";
                break;
              default:
                errorMessage = "Error: ${error.message}";
            }
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        },
      );
    }
  }
}
