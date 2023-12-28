import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:r12shopprovider/firebase/firebasemodel.dart';
import 'package:r12shopprovider/login_signup/loginscreen.dart';
import 'package:r12shopprovider/login_signup/signupscreens.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? username;

  Future<void> displayUserName() async {
    String userName = await FirebaseService().getCurrentUserName();
    username = userName;
    print(username);
  }

  @override
  void initState() {
    super.initState();
    displayUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: displayUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<User?>(
              future: _auth.authStateChanges().first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while checking the user's authentication state
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    // User is already logged in, show the user's information
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            username.toString(),
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Implement logout functionality
                              FirebaseService().SignOut();
                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {});
                              });
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // User is not logged in, show the login/signup options
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'join us to continue',
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
                    );
                  }
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
