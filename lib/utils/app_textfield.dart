import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../gen/colors.gen.dart';
import '../utils/text_style.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String? errorText;
  final TextStyle? textStyle;
  final int? maxLine;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool enableBorder;
  final bool? enable, readOnly;
  final bool isPassword;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final VoidCallback? onTab;
  final bool autofoucs;

  const AppTextField({
    super.key,
    this.maxLine,
    this.maxLength,
    required this.hintText,
    this.prefixIcon,
    this.textStyle,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.enable,
    this.minLines,
    this.labelText = '',
    this.isPassword = false,
    this.validator,
    this.errorText,
    this.onChanged,
    this.enableBorder = false,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.hintTextColor,
    this.onTab,
    this.readOnly,
    this.onFieldSubmitted,
    this.autofoucs = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ],
      readOnly: widget.readOnly ?? false,
      autofocus: widget.autofoucs,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.maxLine,
      cursorColor: ColorName.primaryColor,
      onChanged: widget.onChanged,
      enabled: widget.enable,
      obscureText: widget.isPassword && _obscureText,
      controller: widget.controller,
      validator: widget.validator,
      onTap: widget.onTab,
      style: widget.textStyle ??
          AppTextStyle.appMediumTextStyle(size: 16, color: ColorName.black),
      decoration: InputDecoration(
        labelText: widget.hintText,
        contentPadding: const EdgeInsets.only(left: 10),
        errorBorder: widget.enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              )
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              ),
        border: widget.enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              )
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              ),
        disabledBorder: widget.enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              )
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              ),
        enabledBorder: widget.enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              )
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              ),
        focusedBorder: widget.enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              )
            : UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorName.black.withValues(alpha: .30)),
              ),
        prefixIcon: !widget.enableBorder
            ? Padding(
                padding: const EdgeInsets.all(13),
                child: widget.prefixIcon,
              )
            : widget.prefixIcon,
        prefixIconColor: ColorName.primaryColor,
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: AppTextStyle.appMediumTextStyle(
            color: ColorName.black, size: 13, fontWeight: FontWeight.w400),
        focusColor: Colors.grey,
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: ColorName.black.withValues(alpha: .20),
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
