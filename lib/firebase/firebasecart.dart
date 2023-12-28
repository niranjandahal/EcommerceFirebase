import 'package:flutter/material.dart';
import 'package:r12shopprovider/firebase/firebasemodel.dart';
import 'package:r12shopprovider/login_signup/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addToCart(
    String tittle, double price, List productdetails, BuildContext context) {
  // List ProductDetails = productdetails;
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Please login to add to cart'),
        action: SnackBarAction(
          label: 'Login',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
            );
          },
        ),
      ),
    );
    return;
  } else {
    FirebaseService().addToCart(tittle, price);
    ScaffoldMessenger.of(context).showSnackBar(
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
}
