import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<CartProvider>(context).cart;
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Empty cart',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                final cartItem = cart[index];
                return ListTile(
                  leading: Container(
                    width: 60.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit
                            .fitWidth, // This is the scale you're looking for
                        image: AssetImage(cartItem['imageUrl'].toString()),
                      ),
                    ),
                  ),
                  /*leading: CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
            ),*/
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete product',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Text(
                                  'Are you sure you want to remove the product from your cart?'),
                              actions: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    //Provider.of<CartProvider>(context,listen: false).removeProduct(cartItem);
                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  title: Text(cartItem['title'].toString(),
                      style: Theme.of(context).textTheme.bodySmall),
                  subtitle: Text('Size: ${cartItem['size']}'),
                );
              },
            ),
    );
  }
}
