import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;

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
                      onPressed: () =>
                          Provider.of<CartProvider>(context, listen: false)
                              .removeProduct(cartItem),
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
