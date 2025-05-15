import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';

class FontConstant {
  static final appNormalFont = GoogleFonts.inter(fontStyle: FontStyle.normal);
  static final appItalicFont = GoogleFonts.inter(fontStyle: FontStyle.italic);

  static TextStyle displaySmallTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl4,
    FontWeight fontWeight = FontWeight.w700,
  }) => appNormalFont.copyWith(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl.sp / fontSize.sp,
  );
  static TextStyle displayMediumTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl5,
    FontWeight fontWeight = FontWeight.w700,
  }) => appNormalFont.copyWith(
    fontSize: PropertyConstant.xl5.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl5.sp / fontSize.sp,
  );
  static TextStyle displayLargeTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl6,
    FontWeight fontWeight = FontWeight.w700,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl6.sp / fontSize.sp,
  );

  static TextStyle headingSmallTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl.sp / fontSize.sp,
  );
  static TextStyle headingMediumTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl2,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl2.sp / fontSize.sp,
  );
  static TextStyle headingLargeTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xl3,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xl3.sp / fontSize.sp,
  );

  static TextStyle titleSmallTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.sm,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );
  static TextStyle titleMediumTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.md,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_md.sp / fontSize.sp,
  );
  static TextStyle titleLargeTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.lg,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_lg.sp / fontSize.sp,
  );

  static TextStyle labelSmallTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.sm,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );
  static TextStyle labelSmallSemiTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.sm,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );

  static TextStyle labelMediumTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.md,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_md.sp / fontSize.sp,
  );

  static TextStyle labelMediumSemiTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.md,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_md.sp / fontSize.sp,
  );
  static TextStyle labelLargeTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.lg,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_lg.sp / fontSize.sp,
  );
  static TextStyle labelLargeSemiTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.lg,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_lg.sp / fontSize.sp,
  );

  static TextStyle bodySmallTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xs,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xs.sp / fontSize.sp,
  );
  static TextStyle bodySmallUnderLineTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xs,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    decoration: TextDecoration.underline,
    color: color,
    height: PropertyConstant.l_xs.sp / fontSize.sp,
  );
  static TextStyle bodySmallSemiTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.xs,
    FontWeight fontWeight = FontWeight.w600,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_xs.sp / fontSize.sp,
  );
  static TextStyle bodyMediumTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.sm,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );
  static TextStyle bodyMediumTextStyleFontUnderLine({
    required Color color,
    double fontSize = PropertyConstant.sm,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    decoration: TextDecoration.underline,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );
  static TextStyle bodyLargeTextStyleFont({
    required Color color,
    double fontSize = PropertyConstant.md,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );

  static TextStyle bodylargeTextStyleFontUnderLine({
    required Color color,
    double fontSize = PropertyConstant.md,
    FontWeight fontWeight = FontWeight.w400,
  }) => appNormalFont.copyWith(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    decoration: TextDecoration.underline,
    color: color,
    height: PropertyConstant.l_sm.sp / fontSize.sp,
  );

  // static TextStyle buttonTextStyleFont({required Color color,
  // double fontSize = PropertyConstant.sm,
  // FontWeight fontWeight = FontWeight.w400}) => appNormalFont.copyWith(
  //     fontSize: PropertyConstant.buttonFontSize.sp,
  //     fontWeight: FontWeight.w400,
  //     color: color,
  //     height: PropertyConstant.fontHeight);

  // static TextStyle overLineTextStyleFont({required Color color,
  // double fontSize = PropertyConstant.sm,
  // FontWeight fontWeight = FontWeight.w400}) => appNormalFont.copyWith(
  //     fontSize: PropertyConstant.overLineFontSize.sp,
  //     fontWeight: FontWeight.w400,
  //     color: color,
  //     height: PropertyConstant.fontHeight);

  // static TextStyle captionTextStyleFont({required Color color,
  // double fontSize = PropertyConstant.sm,
  // FontWeight fontWeight = FontWeight.w400}) => appNormalFont.copyWith(
  //     fontSize: PropertyConstant.captionFontSize.sp,
  //     fontWeight: FontWeight.w400,
  //     color: color,
  //     height: PropertyConstant.fontHeight);

  // static TextStyle errorTextFieldStyleFont({required Color color,
  // double fontSize = PropertyConstant.sm,
  // FontWeight fontWeight = FontWeight.w400}) =>
  //     appNormalFont.copyWith(
  //         fontSize: PropertyConstant.errorTextFieldFontSize.sp,
  //         fontWeight: FontWeight.w400,
  //         color: color,
  //         height: PropertyConstant.fontHeight);
}
