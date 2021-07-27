import 'package:car_rental_rdc/globalvariabels.dart';
import 'package:car_rental_rdc/screen/AddingElement.dart';
import 'package:car_rental_rdc/screen/LoginPage.dart';
import 'package:car_rental_rdc/screen/MainScreen.dart';
import 'package:car_rental_rdc/screen/Modeles.dart';
import 'package:car_rental_rdc/screen/Publication.dart';
import 'package:car_rental_rdc/screen/register.dart';
import 'package:car_rental_rdc/screen/serviceScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'models/users.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: (currentFirebaseUser == null) ? LoginPage.id : MainScreen.id,
      routes: {
          RegisterPage.id: (context) => RegisterPage(),
          MainScreen.id: (context) => MainScreen(),
          LoginPage.id: (context) => LoginPage(),
          PublicationPage.id: (context) => PublicationPage(),
          AddingElement.id: (context) => AddingElement(),
          ServiceScreen.id: (context) => ServiceScreen(),
          Modeles.id: (context) => Modeles()
        },
    );
  }
}