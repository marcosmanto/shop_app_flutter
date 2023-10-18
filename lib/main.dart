import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:shop_app_flutter/pages/home_page.dart';
import 'package:shop_app_flutter/my_custom_scroll_behavior.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return CartProvider();
          },
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Shopping App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(254, 206, 1, 1),
            primary: Color.fromRGBO(254, 206, 1, 1),
            secondary: Color.fromRGBO(216, 240, 253, 1),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          chipTheme: ChipThemeData(
            labelPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black54),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            backgroundColor: Color.fromRGBO(245, 247, 249, 1),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              height: .9,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, .55)),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
