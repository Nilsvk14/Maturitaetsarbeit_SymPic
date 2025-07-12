import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maturaarbeit_2025/theme.dart';
import 'package:maturaarbeit_2025/views/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(ThemeData.light().textTheme);
    return MaterialApp(
      title: 'Sympic',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('de'), // German
        Locale('fr'), // French
      ],
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }
}
