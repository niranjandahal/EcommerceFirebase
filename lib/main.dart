// // import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:r12shopprovider/cache/categorycache.dart';
// import 'package:r12shopprovider/firebase_options.dart';
// import 'login_signup/loginscreen.dart';
// // import 'package:http/http.dart' as http;

// // Future<void> fetchCategories() async {
// //   final firstresponse =
// //       await http.get(Uri.parse('https://dummyjson.com/products/categories'));
// //   if (firstresponse.statusCode == 200) {
// //     final data = jsonDecode(firstresponse.body);
// //     // categories = List<String>.from(data);
// //     categoriescache = List<String>.from(data);
// //   }
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await fetchCategories();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'E-commerce app',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       home: SignInPage(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:r12shopprovider/firebase_options.dart';
import 'login_signup/loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      builder: (context, child) {
        return ForcedMobileView(child: child!); // Wrap with ForcedMobileView
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}

// Forced Mobile View Widget
class ForcedMobileView extends StatelessWidget {
  final Widget child;

  const ForcedMobileView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const double mobileWidth = 380;
    const double mobileHeight = 800;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth > mobileWidth || screenHeight > mobileHeight) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Zoom out your browser to see the full screen',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'this is forced mobile view on web so some features might not work properly',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: mobileWidth,
              height: screenHeight > mobileHeight ? mobileHeight : screenHeight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: MediaQuery(
                data: MediaQueryData(
                  size: const Size(mobileWidth, mobileHeight),
                  devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
                  padding: MediaQuery.of(context).padding,
                  viewInsets: MediaQuery.of(context).viewInsets,
                ),
                child: child,
              ),
            ),
          ),
        ],
      );
    }

    // Default rendering for mobile-sized screens
    return child;
  }
}
