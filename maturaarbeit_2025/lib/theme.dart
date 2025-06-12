import "package:flutter/material.dart";

// ColorScheme made with:
// https://material-foundation.github.io/material-theme-builder/

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3a693a),
      surfaceTint: Color(0xff3a693a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbbf0b5),
      onPrimaryContainer: Color(0xff225025),
      secondary: Color(0xff52634f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e8cf),
      onSecondaryContainer: Color(0xff3b4b39),
      tertiary: Color(0xff39656b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf1),
      onTertiaryContainer: Color(0xff1f4d53),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff181d17),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff72796f),
      outlineVariant: Color(0xffc2c9bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa0d49b),
      primaryFixed: Color(0xffbbf0b5),
      onPrimaryFixed: Color(0xff002105),
      primaryFixedDim: Color(0xffa0d49b),
      onPrimaryFixedVariant: Color(0xff225025),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff101f10),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff3b4b39),
      tertiaryFixed: Color(0xffbcebf1),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f3f16),
      surfaceTint: Color(0xff3a693a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff487848),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2a3a29),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff61725d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff083c42),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff48747a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff0e120d),
      onSurfaceVariant: Color(0xff313830),
      outline: Color(0xff4e544b),
      outlineVariant: Color(0xff686f65),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa0d49b),
      primaryFixed: Color(0xff487848),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff305f32),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff61725d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff495946),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff48747a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2e5b61),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c8bf),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffe6e9e0),
      surfaceContainerHigh: Color(0xffdaded5),
      surfaceContainerHighest: Color(0xffcfd3ca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff02340c),
      surfaceTint: Color(0xff3a693a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff245327),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff21301f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3d4d3b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003237),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff215055),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272e26),
      outlineVariant: Color(0xff444b42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa0d49b),
      primaryFixed: Color(0xff245327),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0a3b12),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3d4d3b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff273726),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff215055),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff02393e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6bab2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef2e9),
      surfaceContainer: Color(0xffe0e4db),
      surfaceContainerHigh: Color(0xffd2d6cd),
      surfaceContainerHighest: Color(0xffc4c8bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa0d49b),
      surfaceTint: Color(0xffa0d49b),
      onPrimary: Color(0xff073910),
      primaryContainer: Color(0xff225025),
      onPrimaryContainer: Color(0xffbbf0b5),
      secondary: Color(0xffb9ccb4),
      onSecondary: Color(0xff253423),
      secondaryContainer: Color(0xff3b4b39),
      onSecondaryContainer: Color(0xffd5e8cf),
      tertiary: Color(0xffa1ced5),
      onTertiary: Color(0xff00363c),
      tertiaryContainer: Color(0xff1f4d53),
      onTertiaryContainer: Color(0xffbcebf1),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10140f),
      onSurface: Color(0xffe0e4db),
      onSurfaceVariant: Color(0xffc2c9bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff3a693a),
      primaryFixed: Color(0xffbbf0b5),
      onPrimaryFixed: Color(0xff002105),
      primaryFixedDim: Color(0xffa0d49b),
      onPrimaryFixedVariant: Color(0xff225025),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff101f10),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff3b4b39),
      tertiaryFixed: Color(0xffbcebf1),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb5eab0),
      surfaceTint: Color(0xffa0d49b),
      onPrimary: Color(0xff002d08),
      primaryContainer: Color(0xff6b9d69),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcfe2c9),
      onSecondary: Color(0xff1a2919),
      secondaryContainer: Color(0xff849680),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb6e4eb),
      onTertiary: Color(0xff002b2f),
      tertiaryContainer: Color(0xff6b989e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8ded3),
      outline: Color(0xffadb4a9),
      outlineVariant: Color(0xff8c9288),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff235126),
      primaryFixed: Color(0xffbbf0b5),
      onPrimaryFixed: Color(0xff001602),
      primaryFixedDim: Color(0xffa0d49b),
      onPrimaryFixedVariant: Color(0xff0f3f16),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff061406),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff2a3a29),
      tertiaryFixed: Color(0xffbcebf1),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff083c42),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff41463f),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1a1f19),
      surfaceContainer: Color(0xff252923),
      surfaceContainerHigh: Color(0xff2f342e),
      surfaceContainerHighest: Color(0xff3a3f39),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc8fec2),
      surfaceTint: Color(0xffa0d49b),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9cd097),
      onPrimaryContainer: Color(0xff000f01),
      secondary: Color(0xffe2f5dc),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5c8b0),
      onSecondaryContainer: Color(0xff020e03),
      tertiary: Color(0xffc9f8ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9dcbd1),
      onTertiaryContainer: Color(0xff000e10),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf2e6),
      outlineVariant: Color(0xffbec5b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff235126),
      primaryFixed: Color(0xffbbf0b5),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa0d49b),
      onPrimaryFixedVariant: Color(0xff001602),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb9ccb4),
      onSecondaryFixedVariant: Color(0xff061406),
      tertiaryFixed: Color(0xffbcebf1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff001417),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff4d514b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c211b),
      surfaceContainer: Color(0xff2d322c),
      surfaceContainerHigh: Color(0xff383d36),
      surfaceContainerHighest: Color(0xff444842),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
