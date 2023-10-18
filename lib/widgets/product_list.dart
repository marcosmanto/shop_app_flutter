import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/widgets/product_card.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];
  late int selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = 0;
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(35)),
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              // **** App Title ****
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shoes',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w400, height: 1),
                    ),
                    Text(
                      'Collection',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              // **** Search Area ****
              Expanded(
                child: TextField(
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          // **** Filters Area ****
          Container(
            height: 55,
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = index),
                    child: Chip(
                      backgroundColor: selectedFilter == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).chipTheme.backgroundColor,
                      label: Text(filters[index],
                          style: const TextStyle(height: 1)),
                    ),
                  ),
                );
              },
            ),
          ),
          // **** Product list GRID or LIST ****
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                var filteredProducts = selectedFilter == 0
                    ? products
                    : products
                        .where((element) =>
                            element['company'] == filters[selectedFilter])
                        .toList();
                if (constraints.maxWidth > 650) {
                  return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: ProductDetailsPage(product: product),
                                type: PageTransitionType.leftToRight),
                          );
                          /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    );*/
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: double.parse(product['price'].toString()),
                          image: product['imageUrl'].toString(),
                          backgroundColor: index.isEven
                              ? Theme.of(context).colorScheme.secondary
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: ProductDetailsPage(product: product),
                                type: PageTransitionType.leftToRight),
                          );
                          /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: product),
                      ),
                    );*/
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: double.parse(product['price'].toString()),
                          image: product['imageUrl'].toString(),
                          backgroundColor: index.isEven
                              ? Theme.of(context).colorScheme.secondary
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
