import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/globals.dart';

class AppThemes {
  final G = Get.find<Globals>();

  ThemeData lightTheme(String concep) {
    FlexScheme scheme = G.conceptList[concep] ?? FlexScheme.materialBaseline;
    return FlexThemeData.light(
      scheme: scheme,
      fontFamily: GoogleFonts.sunflower().fontFamily,
      appBarElevation: 0,
      background: FlexColorScheme.light(scheme: scheme).primaryContainer,
      appBarStyle: FlexAppBarStyle.background,
      subThemesData: const FlexSubThemesData(
        cardElevation: 4,
        defaultRadius: 6,
      ),
    );
  }

  ThemeData darkTheme(String concep) {
    FlexScheme scheme = G.conceptList[concep] ?? FlexScheme.materialBaseline;
    return FlexThemeData.dark(
      scheme: scheme,
      fontFamily: GoogleFonts.sunflower().fontFamily,
      appBarElevation: 0,
      background: FlexColorScheme.dark(scheme: scheme).primaryContainer,
      appBarStyle: FlexAppBarStyle.background,
      subThemesData: const FlexSubThemesData(
        cardElevation: 4,
        defaultRadius: 6,
      ),
    );
  }
}
