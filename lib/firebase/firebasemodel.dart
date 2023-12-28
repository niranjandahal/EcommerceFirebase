import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await _createUserDatabase(userCredential.user!.uid, name);
      }
      return userCredential.user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> SignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<String> getCurrentUserName() async {
    User? user = _auth.currentUser;
    String name = ''; // Provide an initial value or a default value

    if (user != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userData = await userRef.get();

      if (userData.exists) {
        name = userData.data()!['name'];
        print(userRef);
      } else {
        print('user not found');
      }
    }
    return name;
  }

  Future<void> addToCart(String itemName, double itemPrice) async {
    try {
      String userName = await getCurrentUserName();
      String userId = _auth.currentUser!.uid;

      await _firestore.collection('users').doc(userId).collection('items').add({
        'name': itemName,
        'price': itemPrice,
        'userName': userName,
      });
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      String userId = _auth.currentUser!.uid;

      final cartSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('items')
          .get();

      List<Map<String, dynamic>> cartItems = [];
      cartSnapshot.docs.forEach((doc) {
        cartItems.add(doc.data());
      });

      return cartItems;
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }

  Future<void> deleteCartItem(String itemName, double itemPrice) async {
    try {
      String userId = _auth.currentUser!.uid;

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('items')
          .where('name', isEqualTo: itemName)
          .where('price', isEqualTo: itemPrice)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document matching the itemName and itemPrice
        final docId = querySnapshot.docs.first.id;
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('items')
            .doc(docId)
            .delete();
      }
    } catch (e) {
      print('Error deleting cart item: $e');
    }
  }

  Future<void> _createUserDatabase(String userId, String name) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
      });
    } catch (e) {
      print('Error creating user database: $e');
    }
  }
}
