import 'package:contactsbuddy/config/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:developer' as dev;

class MobileInputFieldWithLable extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? fieldName;
  final String labelName;
  final bool isMandotary;
  final RegExp? regExp;
  final String? validatorMsg;
  final Color? fillColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelTextStyle;

  const MobileInputFieldWithLable(
      {super.key,
      required this.labelName,
      this.hintText,
      this.controller,
      this.fieldName,
      this.regExp,
      this.validatorMsg,
      this.fillColor,
      this.isMandotary = false,
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
        IntlPhoneField(
          controller: controller,
          flagsButtonPadding: const EdgeInsets.all(8),
          dropdownIconPosition: IconPosition.trailing,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              hintText: hintText,
              prefixIconColor: kPrefixIconColor,
              hintStyle: kInputFieldHintLighterText,
              filled: true,
              fillColor: fillColor ?? kInputFieldBgColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: kInputFieldFocusStrokeColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: kInputFieldErrorStrokeColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: kInputFieldErrorStrokeColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 1.4,
                      style: BorderStyle.solid,
                      color: kAppBgMediumShade))),
          initialCountryCode: 'LK',
          languageCode: "en",
          onChanged: (phone) {
            dev.log(phone.completeNumber, name: "Mobile No OnChange");
          },
          onCountryChanged: (country) {
            dev.log(country.code, name: "Country No OnChange");
          },
        ),
      ],
    );
  }
}
