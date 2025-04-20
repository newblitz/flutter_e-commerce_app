import 'package:flutter/material.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDarkMode = await AppTheme.isDarkMode();
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  
  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await AppTheme.setDarkMode(_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
