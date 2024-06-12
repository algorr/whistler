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
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryWith70Opacity,
    brightness: Brightness.dark,

    // Progress Indicator
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.black),

    // CardView Theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.scaffoldColor, elevation: AppSize.s10),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.newWhite,
      elevation: AppSize.s0,
      shadowColor: ColorManager.primaryWith70Opacity,
      actionsIconTheme: IconThemeData(color: ColorManager.blue),
      iconTheme: IconThemeData(color: ColorManager.blue),
      titleTextStyle: getRegularTextStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: ColorManager.scaffoldColor,
      titleTextStyle: TextStyle(color: ColorManager.black, fontFamily: 'Bruno'),
      contentTextStyle: TextStyle(
          color: ColorManager.black,
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
      disabledColor: ColorManager.grey1,
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
        color: ColorManager.grey1,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getLargeTextStyle(
        color: ColorManager.black,
      ),
      labelLarge:
          getLargeTextStyle(color: ColorManager.black, fontSize: FontSize.s40),
      labelMedium: getLargeTextStyle(
          color: ColorManager.fortuneWheelItemColor, fontSize: FontSize.s22),
      titleLarge:
          getLargeTextStyle(color: ColorManager.white, fontSize: FontSize.s16),
      headlineMedium: getLargeTextStyle(
          color: ColorManager.scaffoldColor, fontSize: FontSize.s18),
    ),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle: getRegularTextStyle(
        color: ColorManager.grey1,
      ),
      labelStyle: getMediumTextStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularTextStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
