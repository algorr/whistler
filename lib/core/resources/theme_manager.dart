import 'package:flutter/material.dart';
import 'package:whistler/core/constants/app_consts.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,
// Main colors of the application
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryWith70Opacity,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.primaryWith70Opacity,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.primary,
    // Progress Indicator
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.white),

    // CardView Theme
    cardTheme: CardTheme(
      color: ColorManager.darkGrey,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),

    /* floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.scaffoldColor, elevation: AppSize.s10), */

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s0,
      shadowColor: ColorManager.primaryWith70Opacity,
      actionsIconTheme: IconThemeData(color: ColorManager.blue),
      iconTheme: IconThemeData(color: ColorManager.blue),
      titleTextStyle: getRegularTextStyle(
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: ColorManager.grey,
      titleTextStyle:
          TextStyle(color: ColorManager.primary, fontFamily: 'Bruno'),
      contentTextStyle: TextStyle(
          color: ColorManager.primary,
          fontFamily: AppConsts.fontFamily,
          fontSize: FontSize.s18),
      elevation: AppSize.s10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryWith70Opacity,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
        ),
      ),
    ),

    // TextTheme
    textTheme: TextTheme(
      displayLarge: getBoldTextStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumTextStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularTextStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getLargeTextStyle(
        color: ColorManager.white,
      ),
      labelLarge:
          getLargeTextStyle(color: ColorManager.white, fontSize: FontSize.s40),
      labelMedium: getLargeTextStyle(
          color: ColorManager.fortuneWheelItemColor, fontSize: FontSize.s22),
      titleLarge:
          getLargeTextStyle(color: ColorManager.white, fontSize: FontSize.s16),
      headlineMedium:
          getLargeTextStyle(color: ColorManager.white, fontSize: FontSize.s18),
    ),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle: getRegularTextStyle(
        color: ColorManager.grey,
      ),
      labelStyle: getMediumTextStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularTextStyle(color: ColorManager.error),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}
