import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maturaarbeit_2025/theme_2.dart';
import 'package:maturaarbeit_2025/views/home.dart';

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
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }
}
