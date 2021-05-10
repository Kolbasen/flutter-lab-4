import 'package:flutter/material.dart';
import 'package:flutter_lab_4/screens/checkout.dart';
import 'package:flutter_lab_4/screens/home.dart';
import 'package:flutter_lab_4/themes/dark_theme.dart';
import 'package:flutter_lab_4/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  String _currentThemeType = prefs.getString('theme') ?? lightTheme;

  runApp(MyApp(
    currentThemeType: _currentThemeType,
  ));
}

class MyApp extends StatelessWidget {
  String currentThemeType;

  MyApp({@required this.currentThemeType});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      currentTheme: currentThemeType == 'light' ? lightTheme : darkTheme,
    );
  }
}

class ThemeWrapper extends StatefulWidget {
  ThemeData currentTheme;

  ThemeWrapper({@required this.currentTheme});

  @override
  _ThemeWrapperState createState() => _ThemeWrapperState();
}

class _ThemeWrapperState extends State<ThemeWrapper> {
  void handleThemeSwitch() async {
    ThemeData newTheme =
        widget.currentTheme == lightTheme ? darkTheme : lightTheme;
    setState(() {
      widget.currentTheme = newTheme;
    });

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', newTheme == lightTheme ? 'light' : 'dark');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3',
      theme: widget.currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(onThemeSwitch: handleThemeSwitch),
        '/checkout': (context) => CheckOutScreen(),
      },
    );
  }
}
