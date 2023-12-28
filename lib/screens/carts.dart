import 'package:flutter/material.dart';
import 'package:r12shopprovider/detailscreen/productdetail.dart';
import 'package:r12shopprovider/firebase/firebasemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:r12shopprovider/login_signup/loginscreen.dart';
import 'package:r12shopprovider/login_signup/signupscreens.dart';

class Carts extends StatefulWidget {
  Carts({
    super.key,
  });

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  List<Map<String, dynamic>> cartitem = [];

  Future<void> fetchCart() async {
    final cart = await FirebaseService().getCartItems();
    setState(() {
      cartitem = cart;
    });
    print(cartitem);
  }

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              //if user is logged in show container else so error
              child: FirebaseAuth.instance.currentUser != null
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 50,
                      child: cartitem.length > 0
                          ? ListView.builder(
                              itemCount: cartitem.length,
                              itemBuilder: (context, index) {
                                final item = cartitem[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return productdetail(
                                    //         herokey: "herokey",
                                    //         productdetails:
                                    //             widget.productdetails,
                                    //       );
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: Dismissible(
                                      // key: Key(itemID[index])
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        setState(() {
                                          cartitem.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Item removed from carts',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.orange[500],
                                            // action: SnackBarAction(
                                            //   label: 'UNDO',
                                            //   onPressed: () {
                                            //     setState(() {
                                            //       cartitem.insert(index, item);
                                            //     });
                                            //   },
                                            // ),
                                          ),
                                        );
                                      },
                                      confirmDismiss: (direction) async {
                                        return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Confirm"),
                                              content: const Text(
                                                  "Are you sure you wish to delete this item?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                    await FirebaseService()
                                                        .deleteCartItem(
                                                            item['name'],
                                                            item['price']);
                                                  },
                                                  child: const Text("DELETE"),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text("CANCEL"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        color: Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ListTile(
                                          title: Text(item['name']),
                                          subtitle:
                                              Text('Price: \$${item['price']}'),
                                          trailing:
                                              Icon(FontAwesomeIcons.deleteLeft),
                                        ),
                                      )),
                                );
                              },
                            )
                          : Container(
                              //if cart is empty show this
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      'Cart is empty',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigate to the login screen
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 48, vertical: 12),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigate to the signup screen
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 48, vertical: 12),
                                      ),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                  : Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 16),
                            Text(
                              'Login to add items',
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to the login screen
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 48, vertical: 12),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to the signup screen
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 48, vertical: 12),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ));
  }
}
