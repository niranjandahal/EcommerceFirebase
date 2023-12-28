import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:r12shopprovider/cache/categorycache.dart';
import 'package:r12shopprovider/detailscreen/productdetail.dart';
import 'package:r12shopprovider/firebase/firebasecart.dart';
import 'package:r12shopprovider/section/shimmereffect.dart';
import 'package:shimmer/shimmer.dart';

class categorysection extends StatefulWidget {
  const categorysection({Key? key});

  @override
  State<categorysection> createState() => _categorysectionState();
}

class _categorysectionState extends State<categorysection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // List<String> categories = [];
  String selectedCategory = 'smartphones';
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    fetchProductsByCategory('smartphones');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchProductsByCategory(String category) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/category/$category'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      products = data["products"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriescache.length,
              itemBuilder: (context, index) {
                final category = categoriescache[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                    fetchProductsByCategory(category);
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: TextStyle(
                        color: selectedCategory == category
                            ? Colors.orange[300]
                            : Colors.grey,
                        fontWeight: selectedCategory == category
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: fetchProductsByCategory(selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetail(
                                productdetails: [
                                  {
                                    "title": product["title"],
                                    "description": product["description"],
                                    "discountPercentage":
                                        product["discountPercentage"],
                                    "price": product["price"],
                                    "rating": product["rating"],
                                    "brand": product["brand"],
                                    "images": product["images"],
                                  }
                                ],
                                herokey: "product$index",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8),
                          color: Colors.white,
                          width: 200,
                          child: Column(
                            children: [
                              Hero(
                                tag: "product$index",
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          product["thumbnail"] ??
                                              'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text(
                                            product["title"],
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              "\$ ${product["price"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Icon(
                                              FontAwesomeIcons.star,
                                              color: Colors.yellow[700],
                                              size: 16,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "${product["rating"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        size: 30,
                                        FontAwesomeIcons.cartShopping,
                                        color: Colors.orange[300],
                                      ),
                                      onTap: () async {
                                        addToCart(
                                            product["title"].toString(),
                                            product["price"].toDouble(),
                                            [
                                              {
                                                "title": product["title"],
                                                "description":
                                                    product["description"],
                                                "discountPercentage": product[
                                                    "discountPercentage"],
                                                "price": product["price"],
                                                "rating": product["rating"],
                                                "brand": product["brand"],
                                                "images": product["images"],
                                              }
                                            ],
                                            context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  height: 290,
                  width: MediaQuery.of(context).size.width,
                  child: ShimmerEffectimagename(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
