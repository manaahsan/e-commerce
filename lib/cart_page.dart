import 'package:eshopping/cart-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProducts = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            final cartItems = cartProducts[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  cartItems['imageUrl'].toString(),
                ),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog<CartProvider>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Delete Product",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          content: const Text(
                              "Are you sure to remove the product from your cart"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop<CartProvider>();
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.blue),
                                )),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(cartItems);
                                  // Provider.of<CartProvider>(context,
                                  //         listen: false)
                                  //     .removeProduct(cartItems);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Yes",
                                    style: TextStyle(color: Colors.red)))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              title: Text(cartItems['title'].toString()),
              subtitle: Text(cartItems['size'].toString()),
            );
          }),
    );
  }
}
