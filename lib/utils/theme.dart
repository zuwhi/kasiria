import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282408849),
      surfaceTint: Color(4282408849),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292273151),
      onPrimaryContainer: Color(4278197054),
      secondary: Color(4280509576),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291291135),
      onSecondaryContainer: Color(4278197806),
      tertiary: Color(4280837002),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291487487),
      onTertiaryContainer: Color(4278197808),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282664782),
      outline: Color(4285822847),
      outlineVariant: Color(4291086032),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280764279),
      secondaryFixed: Color(4291291135),
      onSecondaryFixed: Color(4278197806),
      secondaryFixedDim: Color(4287876598),
      onSecondaryFixedVariant: Color(4278209645),
      tertiaryFixed: Color(4291487487),
      onTertiaryFixed: Color(4278197808),
      tertiaryFixedDim: Color(4288072952),
      onTertiaryFixedVariant: Color(4278209392),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280435571),
      surfaceTint: Color(4282408849),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283921832),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278208615),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282284959),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278208363),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282546849),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282401610),
      outline: Color(4284243815),
      outlineVariant: Color(4286085763),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4283921832),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282277006),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282284959),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280246917),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282546849),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280639879),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278198858),
      surfaceTint: Color(4282408849),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280435571),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278199608),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278208615),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278199610),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278208363),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280362027),
      outline: Color(4282401610),
      outlineVariant: Color(4282401610),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4293258495),
      primaryFixed: Color(4280435571),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278398043),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4278208615),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278202439),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278208363),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202442),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289382399),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278792287),
      primaryContainer: Color(4280764279),
      onPrimaryContainer: Color(4292273151),
      secondary: Color(4287876598),
      onSecondary: Color(4278203468),
      secondaryContainer: Color(4278209645),
      onSecondaryContainer: Color(4291291135),
      tertiary: Color(4288072952),
      onTertiary: Color(4278203471),
      tertiaryContainer: Color(4278209392),
      onTertiaryContainer: Color(4291487487),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309080),
      onSurface: Color(4293059305),
      onSurfaceVariant: Color(4291086032),
      outline: Color(4287533209),
      outlineVariant: Color(4282664782),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4282408849),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280764279),
      secondaryFixed: Color(4291291135),
      onSecondaryFixed: Color(4278197806),
      secondaryFixedDim: Color(4287876598),
      onSecondaryFixedVariant: Color(4278209645),
      tertiaryFixed: Color(4291487487),
      onTertiaryFixed: Color(4278197808),
      tertiaryFixedDim: Color(4288072952),
      onTertiaryFixedVariant: Color(4278209392),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289842175),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278195764),
      primaryContainer: Color(4285829574),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4288140026),
      onSecondary: Color(4278196262),
      secondaryContainer: Color(4284258237),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4288401917),
      onTertiary: Color(4278196264),
      tertiaryContainer: Color(4284520127),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294703871),
      onSurfaceVariant: Color(4291349204),
      outline: Color(4288717740),
      outlineVariant: Color(4286612364),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4280830072),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278194475),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4279383653),
      secondaryFixed: Color(4291291135),
      onSecondaryFixed: Color(4278194975),
      secondaryFixedDim: Color(4287876598),
      onSecondaryFixedVariant: Color(4278205013),
      tertiaryFixed: Color(4291487487),
      onTertiaryFixed: Color(4278194976),
      tertiaryFixedDim: Color(4288072952),
      onTertiaryFixedVariant: Color(4278205016),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289842175),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294507519),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4288140026),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294573055),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288401917),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291349204),
      outlineVariant: Color(4291349204),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4278200664),
      primaryFixed: Color(4292732927),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289842175),
      onPrimaryFixedVariant: Color(4278195764),
      secondaryFixed: Color(4291881727),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4288140026),
      onSecondaryFixedVariant: Color(4278196262),
      tertiaryFixed: Color(4292078335),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288401917),
      onTertiaryFixedVariant: Color(4278196264),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
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
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
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
