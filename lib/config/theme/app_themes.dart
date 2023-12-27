import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xFF625FFD);
Color kPrimaryMediumShade = const Color(0xFFB0AFFE);
Color kPrimaryLighterShade = const Color(0xFFD4D4F4);

Color kAppBgColor = const Color(0xFFFFFFFF);
Color kBlackColor = const Color(0xFF160D1E);

Color kAppBgMediumShade = const Color(0xFFEDEEF2);

Color kGreyColor = const Color(0xFF716E6E);
Color kAppBgLightestShade = const Color(0xFFF3F3F3);
Color kAppBgLighterShade = const Color(0xFFF1F1F1);
Color kGreyLightShade = const Color(0xFFA5A5A5);
Color kGreyMediumShade = const Color(0xFF888888);
Color kDarkGreyShade = const Color(0xFF444444);
Color kDarkerGreyShade = const Color(0xFF363333);

Color kSuccessColor = const Color(0xFF189516);
Color kWarnningColor = const Color(0XFFF5B14B);
Color kErrorColor = const Color(0XFFD1212C);

Color kButtonPrimaryColor = kPrimaryColor;
Color kButtonTextWhiteColor = const Color(0xFFFFFFFF);
Color kButtonTextPrimaryColor = kPrimaryColor;

//Input TextFild Colors
Color kInputFieldBgColor = kAppBgColor;

Color kInputFieldStrokeColor = kAppBgMediumShade;
Color kInputFieldFocusStrokeColor = kPrimaryLighterShade;
Color kInputFieldErrorStrokeColor = kErrorColor;
Color kInputFieldFocusErrorStrokeColor = kErrorColor;

Color kPrefixIconColor = kGreyLightShade;
Color kInputFieldHintTextColor = kGreyMediumShade;
Color kInputFieldHintTextLightShade = kAppBgLighterShade;

TextStyle kBlackHeaddertextStyle = GoogleFonts.roboto(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: kBlackColor,
);

TextStyle kGreyBodytextStyle = GoogleFonts.roboto(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kGreyColor,
);

//Input Field Text styles
TextStyle kInputFieldText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: kDarkGreyShade,
    letterSpacing: 0.2);

TextStyle kInputFieldHintText = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kInputFieldHintTextColor,
);

TextStyle kInputFieldHintLighterText = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kGreyLightShade,
);

TextStyle kInputFieldLabelLighterText = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kGreyMediumShade,
);

TextStyle kInputFieldLabelDarkText = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kDarkerGreyShade,
);

TextStyle kFilledButtonTextstyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kButtonTextWhiteColor,
);

TextStyle kwarningText = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: kErrorColor,
);

TextStyle kBlackSmalltextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kDarkGreyShade,
);

TextStyle kPrimaryColorSmalltextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
);
