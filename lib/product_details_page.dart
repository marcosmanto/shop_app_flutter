import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.product['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          //const Spacer(),
          // **** Product Image ****
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Image.asset(widget.product['imageUrl'] as String),
            ),
          ),
          //const Spacer(flex: 2),
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (BuildContext context, int index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () => setState(() => selectedSize = size),
                          child: Chip(
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            label: Text(size.toString()),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            side: BorderSide(color: Colors.black12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      if (selectedSize != 0) {
                        Map<String, Object> productToAdd =
                            Map.from(widget.product);
                        productToAdd['size'] = selectedSize;
                        Provider.of<CartProvider>(context, listen: false)
                            .addProduct(productToAdd);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green[300],
                            content: Text(
                              'Product added to cart successfully',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )));
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a size')));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 50)),
                    label: Text('Add To Cart'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
