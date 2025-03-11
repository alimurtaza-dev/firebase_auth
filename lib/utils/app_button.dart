import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';
import 'text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });
  final bool isLoading;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: WidgetStatePropertyAll(ColorName.primaryColor)),
      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator(
              color: ColorName.white,
            )
          : Text(
              title,
              style: AppTextStyle.appMediumTextStyle(color: ColorName.white),
            ),
    );
  }
}
