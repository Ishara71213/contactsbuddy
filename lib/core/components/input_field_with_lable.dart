import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:contactsbuddy/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:flutter/material.dart';

class InputFieldWithLable extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? fieldName;
  final String labelName;
  final bool isMandotary;
  final bool isTextArea;
  final bool obscureText;
  final RegExp? regExp;
  final String? validatorMsg;
  final Color? fillColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelTextStyle;

  const InputFieldWithLable(
      {super.key,
      required this.labelName,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.fieldName,
      this.regExp,
      this.validatorMsg,
      this.fillColor,
      this.isTextArea = false,
      this.isMandotary = false,
      this.obscureText = false,
      this.padding,
      this.labelTextStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.only(bottom: 12),
          child: Text(
            labelName,
            style: labelTextStyle ?? kInputFieldLabelDarkText,
          ),
        ),
        TextFormInput(
          fieldName: fieldName ?? labelName,
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          regExp: regExp,
          validatorMsg: validatorMsg,
          fillColor: fillColor,
          isTextArea: isTextArea,
          isMandotary: isMandotary,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
