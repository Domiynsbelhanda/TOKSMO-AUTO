import 'package:car_rental_rdc/Nouveau%20dossier/available_accessoire.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/available_cars.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/available_piece.dart';
import 'package:car_rental_rdc/globalvariabels.dart';
import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/screen/AddingElement.dart';
import 'package:car_rental_rdc/screen/LoginPage.dart';
import 'package:car_rental_rdc/screen/MainScreen.dart';
import 'package:car_rental_rdc/screen/MyProfileCard.dart';
import 'package:car_rental_rdc/screen/Publication.dart';
import 'package:car_rental_rdc/screen/marque.dart';
import 'package:car_rental_rdc/screen/register.dart';
import 'package:car_rental_rdc/screen/serviceScreen.dart';
import 'package:car_rental_rdc/track/available_cars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'location/available_cars.dart';
import 'engin/available_cars.dart';
import 'models/users.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;

  String userid = currentFirebaseUser.uid;

  FirebaseFirestore.instance.collection('Users').doc('${userid}').snapshots()
      .forEach((element) {
    currentUser = Users(
        email: element.data()['email'],
        image: element.data()['image'],
        fullName: element.data()['name'],
        phone: element.data()['phone'],
        type: element.data()['type'],
        id: element.id
    );
  });

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
          Marques.id: (context) => Marques(),
          AvailableCars.id: (context) => AvailableCars(),
          AvailableEngin.id: (context) => AvailableEngin(),
          AvailableTrack.id: (context) => AvailableTrack(),
          AvailableLocation.id: (context) => AvailableLocation(),
          AvailablePiece.id: (context) => AvailablePiece(),
          AvailableAccessoire.id: (context) => AvailableAccessoire(),
        },
    );
  }
}