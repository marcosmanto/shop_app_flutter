import 'package:flutter/material.dart';
import 'package:shop_app_flutter/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(254, 206, 1, 1),
          primary: Color.fromRGBO(254, 206, 1, 1),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
        ),
        chipTheme: ChipThemeData(
          labelPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black54),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          backgroundColor: Color.fromRGBO(245, 247, 249, 1),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
