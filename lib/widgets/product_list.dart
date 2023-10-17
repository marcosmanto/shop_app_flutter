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
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters.first;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
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
                    Text(
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
                  decoration: InputDecoration(
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
                final filter = filters[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = filter),
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).chipTheme.backgroundColor,
                      label: Text(filter, style: TextStyle(height: 1)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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
                      : Color.fromRGBO(245, 247, 249, 1),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
