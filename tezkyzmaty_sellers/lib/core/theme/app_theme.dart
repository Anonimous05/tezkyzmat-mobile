import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';

import 'color.dart';
import 'text_style.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: TezColor.white,
    useMaterial3: TezColor.isMaterial3,
    splashFactory: InkRipple.splashFactory,
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: TezColor.warning600,
      indicatorColor: TezColor.primary,
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13.0)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: TezColor.primary,
      backgroundColor: TezColor.neutral50,
      contentTextStyle: TextStyleConstant.labelMediumLightTheme,
    ),
    textTheme: TextTheme(
      labelSmall: TextStyleConstant.labelSmallLightTheme,
      labelMedium: TextStyleConstant.labelMediumLightTheme,
      labelLarge: TextStyleConstant.labelLargeLightTheme,
      titleSmall: TextStyleConstant.titleSmallLightTheme,
      titleMedium: TextStyleConstant.titleMediumLightTheme,
      titleLarge: TextStyleConstant.titleLargeLightTheme,
      headlineSmall: TextStyleConstant.headingSmallLightTheme,
      headlineMedium: TextStyleConstant.headingMediumLightTheme,
      headlineLarge: TextStyleConstant.headingLargeLightTheme,
      displaySmall: TextStyleConstant.displaySmallLightTheme,
      displayMedium: TextStyleConstant.displayMediumLightTheme,
      displayLarge: TextStyleConstant.displayLargeLightTheme,
      bodyMedium: TextStyleConstant.bodyMediumLightTheme,
      bodyLarge: TextStyleConstant.bodyLargeLightTheme,
      bodySmall: TextStyleConstant.bodySmallLightTheme,
    ),
    colorScheme: ColorScheme.fromSeed(
      primary: TezColor.primary,
      onPrimary: TezColor.neutral50,
      primaryContainer: TezColor.primary100,
      onPrimaryContainer: TezColor.primary700,
      secondary: TezColor.secondary,
      onSecondary: TezColor.neutral50,
      secondaryContainer: TezColor.secondary100,
      onSecondaryContainer: TezColor.secondary700,
      tertiary: TezColor.green300,
      onTertiary: TezColor.neutral50,
      tertiaryContainer: TezColor.green100,
      onTertiaryContainer: TezColor.green700,
      error: TezColor.error600,
      errorContainer: TezColor.error50,
      onError: TezColor.neutral50,
      onErrorContainer: TezColor.error700,
      surface: TezColor.neutral50,
      onSurface: TezColor.neutral900,
      surfaceContainerHighest: TezColor.neutral300,
      onSurfaceVariant: TezColor.neutral400,
      outline: TezColor.neutral600,
      onInverseSurface: TezColor.neutral50,
      inverseSurface: TezColor.neutral900,
      inversePrimary: TezColor.primary700,
      shadow: TezColor.primary600,
      surfaceTint: Colors.transparent,
      scrim: TezColor.neutral800,
      seedColor: TezColor.primary,
    ),
    focusColor: TezColor.focusLightThemeColor,
    hintColor: TezColor.hintLightThemeColor,
    unselectedWidgetColor: TezColor.unSelectedWidgetLightThemeColor,
    shadowColor: TezColor.selectedRowLightThemeColor,
    iconTheme: const IconThemeData(color: TezColor.iconLightThemeColor),
    indicatorColor: TezColor.indicatorLightThemeColor,
    cardTheme: CardTheme(
      shape: PropertyConstant.cardShapeBorder,
      color: TezColor.cardLightThemeColor,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: TextStyleConstant.labelMediumLightTheme,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleSize: Size(48.w, 4.w),
      dragHandleColor: TezColor.borderPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: TezColor.backgroundPrimary,
      iconTheme: IconThemeData(color: TezColor.iconPrimary, size: 14.r),
      surfaceTintColor: TezColor.warning600,
      elevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      titleTextStyle: TextStyleConstant.titleMediumLightTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 10.0,
      ),
      border: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      errorMaxLines: 1,
      errorBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyleConstant.bodySmallLightTheme,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: TezColor.white,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    useMaterial3: TezColor.isMaterial3,
    splashFactory: InkRipple.splashFactory,
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: TezColor.primary900,
      indicatorColor: TezColor.primary,
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13.0)),
    ),
    textTheme: TextTheme(
      labelSmall: TextStyleConstant.labelSmallDarkTheme,
      labelMedium: TextStyleConstant.labelMediumDarkTheme,
      labelLarge: TextStyleConstant.labelLargeDarkTheme,
      titleSmall: TextStyleConstant.titleSmallDarkTheme,
      titleMedium: TextStyleConstant.titleMediumDarkTheme,
      titleLarge: TextStyleConstant.titleLargeDarkTheme,
      headlineSmall: TextStyleConstant.headingSmallDarkTheme,
      headlineMedium: TextStyleConstant.headingMediumDarkTheme,
      headlineLarge: TextStyleConstant.headingLargeDarkTheme,
      displaySmall: TextStyleConstant.displaySmallDarkTheme,
      displayMedium: TextStyleConstant.displayMediumDarkTheme,
      displayLarge: TextStyleConstant.displayLargeDarkTheme,
      bodyMedium: TextStyleConstant.bodyMediumLightTheme,
      bodyLarge: TextStyleConstant.bodyLargeLightTheme,
      bodySmall: TextStyleConstant.bodySmallLightTheme,
    ),
    focusColor: TezColor.focusDarkThemeColor,
    hintColor: TezColor.hintDarkThemeColor,
    unselectedWidgetColor: TezColor.unSelectedWidgetDarkThemeColor,
    shadowColor: TezColor.selectedRowDarkThemeColor,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.black)),
    ),
    iconTheme: const IconThemeData(color: TezColor.iconDarkThemeColor),
    indicatorColor: TezColor.indicatorDarkThemeColor,
    cardTheme: CardTheme(
      shape: PropertyConstant.cardShapeBorder,
      color: TezColor.cardDarkThemeColor,
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      primary: TezColor.blue,
      onPrimary: TezColor.neutral50,
      primaryContainer: TezColor.primary700,
      onPrimaryContainer: TezColor.primary200,
      secondary: TezColor.secondary200,
      onSecondary: TezColor.primary,
      secondaryContainer: TezColor.secondary600,
      onSecondaryContainer: TezColor.secondary700,
      tertiary: TezColor.green300,
      onTertiary: TezColor.neutral50,
      tertiaryContainer: TezColor.green100,
      onTertiaryContainer: TezColor.green700,
      error: TezColor.error700,
      errorContainer: TezColor.error50,
      onError: TezColor.neutral50,
      onErrorContainer: TezColor.error800,
      surface: TezColor.neutral900,
      onSurface: TezColor.neutral50,
      surfaceContainerHighest: TezColor.neutral700,
      onSurfaceVariant: TezColor.neutral600,
      outline: TezColor.neutral600,
      onInverseSurface: TezColor.neutral50,
      inverseSurface: TezColor.neutral800,
      inversePrimary: TezColor.primary,
      shadow: TezColor.primary600,
      surfaceTint: TezColor.cardDarkThemeColor,
      scrim: TezColor.neutral800,
      seedColor: TezColor.primary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: TextStyleConstant.labelMediumDarkTheme,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleSize: Size(48.w, 4.w),
      dragHandleColor: TezColor.borderPrimary,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: TezColor.primary,
      elevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      titleTextStyle: TextStyleConstant.titleMediumDarkTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 10.0,
      ),
      border: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      errorMaxLines: 1,
      enabledBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: PropertyConstant.textFieldBorderRadius,
        borderSide: const BorderSide(color: TezColor.primary),
      ),
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyleConstant.bodySmallDarkTheme,
      ),
    ),
  );
}
