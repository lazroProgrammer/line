import 'package:flutter/material.dart';

extension CustomColors on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
}

extension CustomTextStyles on BuildContext {
  TextStyle get headline1 => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get bodyText1 => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get caption => Theme.of(this).textTheme.labelLarge!;
}

Color adjustBrightness(
  Color color, {
  required bool isDarkMode,
  double? brightness,
}) {
  // Convert the color to HSL
  HSLColor hsl = HSLColor.fromColor(color);

  // If dark mode, decrease lightness; if light mode, increase lightness
  double adjustedLightness =
      isDarkMode
          ? 0.1 +
              hsl
                  .lightness // Invert the lightness for dark mode
          : hsl.lightness +
              0.05; // Reduce the lightness for light mode (10% of original)
  if (brightness != null) {
    adjustedLightness = brightness;
  }
  // Ensure the lightness is clamped between 0.0 and 1.0
  adjustedLightness = adjustedLightness.clamp(0.0, 1.0);

  // Create a new HSLColor with the adjusted lightness
  HSLColor adjustedHsl = hsl.withLightness(adjustedLightness);

  // Convert the adjusted HSLColor back to a Color
  return adjustedHsl.toColor();
}

class AppTheme {
  // Primary and secondary colors
  static const Color primaryColor = Color.fromARGB(255, 19, 122, 182);
  // static const Color primaryColor = Color(0xFF207cff);
  static const Color secondaryColor = Color.fromARGB(255, 22, 144, 214);

  // Background and surface colors
  static const Color backgroundColor = Color(0xFFF6F6F6);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  // Text colors
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFF757575);

  // Error color
  static const Color errorColor = Color(0xFFB00020);

  // Typography
  // static const String fontFamily =
  //     'Roboto'; // Replace with your preferred font family

  // Text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
    // fontFamily: fontFamily,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: primaryTextColor,
    // fontFamily: fontFamily,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
    // fontFamily: fontFamily,
  );

  static const TextStyle headline1d = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 252, 251, 251),
    // fontFamily: fontFamily,
  );

  static const TextStyle bodyText1d = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 206, 206, 206),
    // fontFamily: fontFamily,
  );

  static const TextStyle captiond = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 192, 192, 192),
    // fontFamily: fontFamily,
  );

  // Theme data
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: adjustBrightness(primaryColor, isDarkMode: false),
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: adjustBrightness(primaryColor, isDarkMode: false),
      secondary: adjustBrightness(secondaryColor, isDarkMode: false),
      surface: surfaceColor,
      error: errorColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: headline1,
      bodyLarge: bodyText1,
      labelLarge: caption,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.black87,
      ),
    ),
    // fontFamily: fontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: adjustBrightness(primaryColor, isDarkMode: true),
    scaffoldBackgroundColor: Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: adjustBrightness(primaryColor, isDarkMode: true),
      secondary: adjustBrightness(secondaryColor, isDarkMode: true),
      surface: Color(0xFF1E1E1E),
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
    textTheme: const TextTheme(
      headlineLarge: headline1d,
      bodyLarge: bodyText1d,
      labelLarge: captiond,
    ),
    // fontFamily: fontFamily,
  );
}
