import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyConstant {
  static final ShapeBorder cardShapeBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));
  static final BorderRadius textFieldBorderRadius = BorderRadius.circular(18.0);
  static final BorderRadius labelBorderRadius = BorderRadius.circular(12.0);
  static const BorderRadius bottomSheetBorderRadius = BorderRadius.only(
      topRight: Radius.circular(14.0), topLeft: Radius.circular(14.0));

  static final OutlineInputBorder searchTextFieldOutlineInputBorder =
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)));

  //ITEM-VIEW
  static const BorderRadius mobileImageContainerBorderRadius =
      BorderRadius.all(Radius.circular(4.0));

  //CHART
  static const BorderRadius columnSeriesBorder =
      BorderRadius.zero; //BorderRadius.vertical(top: Radius.circular(0));

  //INPUT TYPE
  static void keyboardHide() => FocusManager.instance.primaryFocus
      ?.unfocus(); //Flutter version 2 or latest

  static const TextInputType nameTextInputType = TextInputType.name;
  static const TextInputType numberTextInputType = TextInputType.number;
  static const TextInputType emailTextInputType = TextInputType.emailAddress;
  static const TextInputType textInputType = TextInputType.text;
  static const TextInputType multipleTextInputAction = TextInputType.multiline;
  static const TextInputType urlTextInputType = TextInputType.url;

  static const TextInputAction nextTextInputAction = TextInputAction.next;
  static const TextInputAction doneTextInputAction = TextInputAction.done;

  static const bool passwordObscureText = true;

  static const int passwordMinLength = 6;
  static const int mobileMaxLength = 10;
  static const int passwordMaxLength = 20;
  static const int shopNameMaxLength = 20;
  static const int ownerNameMaxLength = 30;
  static const int imeiNumberLength = 15;
  static const int pinCodeLength = 6;
  static const int panNumberLength = 10;
  static const int uniqueIdentificationNumberLength = 12;
  static const int sellingPriceMaxLength = 10;

  static const double bottomIconSize = 25.0;

  static const int textFieldBetweenSpace = 35;
  static const int textFieldButtonSpace = 25;
  static const int textFieldButton10Space = 10;

  //FONT SIZE

  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double md = 16.0;
  static const double md2 = 18.0;
  static const double lg = 22.0;
  static const double xl = 24.0;
  static const double xl2 = 28.0;
  static const double xl3 = 32.0;
  static const double xl4 = 36.0;
  static const double xl5 = 45.0;
  static const double xl6 = 57.0;

  static const double l_xs = 16.0;
  static const double l_sm = 20.0;
  static const double l_md = 24.0;
  static const double l_lg = 28.0;
  static const double l_xl = 32.0;
  static const double l_xl2 = 36.0;
  static const double l_xl3 = 40.0;
  static const double l_xl4 = 44.0;
  static const double l_xl5 = 52.0;
  static const double l_xl6 = 64.0;

  //Border radius
  static const double r_none = 0.0;
  static const double r_sm = 2.0;
  static const double r_md = 4.0;
  static const double r_lg = 8.0;
  static const double r_round = 64.0;

  static const double fontHeight = 1.3;

  SliverGridDelegateWithFixedCrossAxisCount
      sliverGridDelegateWithFixedCrossAxisCount(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20.0.r,
      mainAxisSpacing: 20.0.r,
      mainAxisExtent: ((MediaQuery.sizeOf(context).width - (20.r - 32.w)) / 2) +
          (130.w + 12.w),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount
      sliverGridDelegateWithFixedCrossAxisCountFav(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20.0.r,
      mainAxisSpacing: 20.0.r,
      mainAxisExtent: ((MediaQuery.sizeOf(context).width - (20.r - 32.w)) / 2) +
          (10.w + 12.w),
    );
  }
}
