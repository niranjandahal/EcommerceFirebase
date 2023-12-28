import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:r12shopprovider/detailscreen/productdetail.dart';
import 'package:r12shopprovider/firebase/firebasemodel.dart';
import 'package:r12shopprovider/login_signup/loginscreen.dart';
import 'package:r12shopprovider/section/shimmereffect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class HomeTopSection extends StatefulWidget {
  const HomeTopSection({super.key});

  @override
  State<HomeTopSection> createState() => _HomeTopSectionState();
}

class _HomeTopSectionState extends State<HomeTopSection> {
  List<Map<String, dynamic>> allproductlist = []; // List to store products

  Future<void> loadallproduct() async {
    final response =
        await http.get(Uri.parse("https://dummyjson.com/products"));

    if (response.statusCode == 200) {
      // Check if the response was successful
      final data = jsonDecode(response.body);
      allproductlist = List<Map<String, dynamic>>.from(
          data['products']); // Assign products to the list
    } else {}
  }

  @override
  void initState() {
    super.initState();
    loadallproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: loadallproduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allproductlist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => productdetail(
                          productdetails: [
                            {
                              "title": allproductlist[index]["title"],
                              "description": allproductlist[index]
                                  ["description"],
                              "discountPercentage": allproductlist[index]
                                  ["discountPercentage"],
                              "price": allproductlist[index]["price"],
                              "rating": allproductlist[index]["rating"],
                              "brand": allproductlist[index]["brand"],
                              "images": allproductlist[index]["images"],
                            }
                          ],
                          herokey: "producttop$index",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.white,
                    width: 200,
                    child: Column(
                      children: [
                        Hero(
                          transitionOnUserGestures: true,
                          tag: "producttop$index",
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(allproductlist[index]
                                          ['thumbnail'] ??
                                      'https://picsum.photos/200/300'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      allproductlist[index]['title'].toString(),
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    allproductlist[index]['price'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    User? user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please login to add to cart'),
                                          action: SnackBarAction(
                                            label: 'Login',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInPage(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                      return;
                                    } else {
                                      FirebaseService().addToCart(
                                        allproductlist[index]['title']
                                            .toString(),
                                        allproductlist[index]['price']
                                            .toDouble(),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.orange[500],
                                          content: Text(
                                            'Item added to cart successfully',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.cartShopping,
                                    size: 30,
                                    color: Colors.orange[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return ShimmerEffectimagename();
          }
        },
      ),
    );
  }
}
