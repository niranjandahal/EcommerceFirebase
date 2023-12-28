import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:r12shopprovider/cache/categorycache.dart';
import 'package:r12shopprovider/firebase_options.dart';
import 'login_signup/loginscreen.dart';
import 'package:http/http.dart' as http;

Future<void> fetchCategories() async {
  final firstresponse =
      await http.get(Uri.parse('https://dummyjson.com/products/categories'));
  if (firstresponse.statusCode == 200) {
    final data = jsonDecode(firstresponse.body);
    // categories = List<String>.from(data);
    categoriescache = List<String>.from(data);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fetchCategories();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}
