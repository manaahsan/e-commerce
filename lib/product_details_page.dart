import 'package:eshopping/cart-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'size': selectedSize,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product added successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select size!..")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
          ),
        ),
        body: Column(
          children: [
            Center(
                child: Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            const Spacer(),
            Image.asset(
              widget.product['imageUrl'] as String,
              height: 175,
            ),
            const Spacer(flex: 2),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(216, 240, 253, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${widget.product['price']}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            (widget.product['sizes'] as List<int>).length,
                        itemBuilder: (context, index) {
                          final size =
                              (widget.product['sizes'] as List<int>)[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                child: Chip(
                                    backgroundColor: selectedSize == size
                                        ? const Color.fromRGBO(254, 206, 1, 1)
                                        : const Color.fromRGBO(
                                            245, 247, 249, 1),
                                    label: Text(size.toString()))),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          onTap();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(254, 206, 1, 1),
                            minimumSize: const Size(double.infinity, 50)),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
