import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CarRental());
}

class CarRental extends StatelessWidget {
  const CarRental({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toksmo Auto',
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
