import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_practice/screens/login/verify_code.dart';
import 'package:firebase_auth_practice/utils/app_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final mobilePhoneController = TextEditingController();

  bool isLoading = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    mobilePhoneController.dispose();
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
                keyboardType: TextInputType.number,
                controller: mobilePhoneController,
                hintText: '+92123456789',
                enableBorder: true,
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    return null;
                  } else {
                    return "Enter Phone Number";
                  }
                },
              ),
              AppButton(
                isLoading: isLoading,
                title: 'Login with mobile',
                onPressed: () {
                  _login();
                },
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

      _auth.verifyPhoneNumber(
        phoneNumber: mobilePhoneController.text,
        verificationCompleted: (_) {},
        verificationFailed: (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.code)));
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyCode(
                  verificationId: verificationId,
                ),
              ));
          setState(() {
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(verificationId)));
          setState(() {
            isLoading = false;
          });
        },
        
      );
    }
  }
}
