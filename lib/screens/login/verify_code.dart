import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practice/screens/posts/posts_screen.dart';
import 'package:firebase_auth_practice/screens/signup/sign_up.dart';
import 'package:firebase_auth_practice/utils/app_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final codeController = TextEditingController();

  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    codeController.dispose();
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
                controller: codeController,
                hintText: 'Enter 6 digit code',
                enableBorder: true,
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    return null;
                  } else {
                    return "Enter 6 digit code";
                  }
                },
              ),
              AppButton(
                isLoading: isLoading,
                title: 'Login',
                onPressed: () {
                  _verifyCodeAndLogin(widget.verificationId);
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
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyCodeAndLogin(String verificationId) async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final AuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: codeController.text);
      try {
        await _auth.signInWithCredential(AuthCredential);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Successfully")));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PostsScreen(),
            ));
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
