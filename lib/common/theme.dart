import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF1DB1B7);
const Color secondaryColor = Color(0xFF44D7DD);
const Color thirdyColor = Color(0xFF00C2CB);
const Color fourtyColor = Color(0xFFA6F3FF);
const Color fiveColor = Color(0xFF446266);
Color backgroundColor = const Color(0xFF121111);
const Color textColor = Color(0xff8A9A9D);
// const Color kRichBlack = Color(0xFF000814);
// const Color kOxfordBlue = Color(0xFF001D3D);
// const Color kPrussianBlue = Color(0xFF003566);
// const Color kMikadoYellow = Color(0xFFffc300);
// const Color kDavysGrey = Color(0xFF4B5358);
// const Color kGrey = Color(0xFF303030);

final elevatedButtonTheme = ElevatedButtonThemeData(
    style: TextButton.styleFrom(
  side: const BorderSide(color: secondaryColor),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
));
const listTileTheme = ListTileThemeData(
  horizontalTitleGap: 1,
);

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: elevatedButtonTheme,
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: backgroundColor,
      secondary: secondaryColor,
      onSecondary: Colors.tealAccent,
      error: Colors.redAccent,
      onError: Colors.red,
      background: Colors.black38,
      onBackground: Colors.white10,
      surface: backgroundColor,
      onSurface: textColor),
);
