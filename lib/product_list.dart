import 'package:flutter/material.dart';

import 'package:eshopping/global_variables.dart';
import 'package:eshopping/product_details_page.dart';
import 'package:eshopping/products_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductList> {
  final List<String> filters = const ["All", "Addidas", "Nike", "Bata"];
  late String selecteTap;
  @override
  void initState() {
    super.initState();
    selecteTap = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));
    return SafeArea(
        child: Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "shoes\n Collections",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: border),
            )),
          ],
        ),
        SizedBox(
            height: 120,
            child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selecteTap = filter;
                          });
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: selecteTap == filter
                              ? const Color.fromRGBO(254, 206, 1, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                              color: Color.fromRGBO(245, 247, 249, 1)),
                          label: Text(filter),
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: selecteTap == filter
                                  ? Colors.white
                                  : const Color.fromARGB(255, 255, 145, 0)),
                        )),
                  );
                })),
        Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetails(product: product);
                      }));
                    },
                    child: ProductsCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      bacground: index.isOdd
                          ? const Color.fromRGBO(245, 247, 249, 1)
                          : const Color.fromRGBO(216, 240, 253, 1),
                    ),
                  );
                }))
      ],
    ));
  }
}
