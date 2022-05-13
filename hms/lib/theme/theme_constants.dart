import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.greyLaw,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 18,
  appBarStyle: FlexAppBarStyle.primary,
  appBarOpacity: 0.95,
  appBarElevation: 0,
  transparentStatusBar: true,
  tabBarStyle: FlexTabBarStyle.forAppBar,
  tooltipsMatchBackground: true,
  swapColors: false,
  lightIsWhite: false,
  useSubThemes: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.roboto().fontFamily,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    fabUseShape: true,
    interactionEffects: true,
    bottomNavigationBarElevation: 0,
    bottomNavigationBarOpacity: 0.95,
    navigationBarOpacity: 0.95,
    navigationBarMutedUnselectedText: true,
    navigationBarMutedUnselectedIcon: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: true,
    blendOnColors: true,
    blendTextTheme: true,
    popupMenuOpacity: 0.95,
  ),
);
ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.greyLaw,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 18,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.95,
  appBarElevation: 0,
  transparentStatusBar: true,
  tabBarStyle: FlexTabBarStyle.forAppBar,
  tooltipsMatchBackground: true,
  swapColors: false,
  darkIsTrueBlack: false,
  useSubThemes: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.roboto().fontFamily,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    fabUseShape: true,
    interactionEffects: true,
    bottomNavigationBarElevation: 0,
    bottomNavigationBarOpacity: 0.95,
    navigationBarOpacity: 0.95,
    navigationBarMutedUnselectedText: true,
    navigationBarMutedUnselectedIcon: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: true,
    blendOnColors: true,
    blendTextTheme: true,
    popupMenuOpacity: 0.95,
  ),
);
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

// ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: primaryColor,
//     floatingActionButtonTheme:
//         const FloatingActionButtonThemeData(backgroundColor: secandryColor),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ButtonStyle(
//             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                 const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
//             shape: MaterialStateProperty.all<OutlinedBorder>(
//                 RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0))),
//             backgroundColor: MaterialStateProperty.all<Color>(secandryColor))),
//     inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20.0),
//             borderSide: BorderSide.none),
//         filled: true,
//         fillColor: Colors.grey.withOpacity(0.1)));

// ThemeData darkTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     primary: primaryColor,
//     secondary: secandryColor,
//     surface: Colors.purpleAccent,
//     background: backgroundColor,
//     error: textColor,
//     onPrimary: Colors.red,
//     onSecondary: Colors.deepOrange,
//     onSurface: textColor,
//     onBackground: backgroundColor,
//     onError: Colors.redAccent,
//     brightness: Brightness.dark,
//   ),
//   switchTheme: SwitchThemeData(
//     trackColor: MaterialStateProperty.all<Color>(primaryColor),
//     thumbColor: MaterialStateProperty.all<Color>(secandryColor),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20.0),
//           borderSide: BorderSide.none),
//       filled: true,
//       fillColor: Colors.grey.withOpacity(0.1)),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//               const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
//           shape: MaterialStateProperty.all<OutlinedBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0))),
//           backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
//           foregroundColor: MaterialStateProperty.all<Color>(secandryColor),
//           overlayColor: MaterialStateProperty.all<Color>(textColor))),
// );
