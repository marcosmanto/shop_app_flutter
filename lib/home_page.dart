import 'package:flutter/material.dart';
import 'package:shop_app_flutter/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductList(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => currentPage = value),
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }
}
