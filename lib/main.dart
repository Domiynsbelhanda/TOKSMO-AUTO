import 'package:animated_splash_screen/animated_splash_screen.dart';
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
import 'models/data.dart';
import 'models/users.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;

  donnees.clear();

  Query collectionReference1 = FirebaseFirestore.instance
      .collection("Datas")
      .orderBy('timestamp', descending: true);


  collectionReference1
      .snapshots()
      .listen((data) => data.docs.forEach((doc) {

    donnees.add(
        new Vehicule(
            etat: doc.data()["etat"],
            prix: doc.data()["prix"],
            marque: doc.data()["marque"],
            carrosserie: doc.data()["carrosserie"],
            modele: doc.data()["modele"],
            poignet: doc.data()["poignet"],
            carburant: doc.data()["carburant"],
            couleur: doc.data()["couleur"],
            kilometrage: doc.data()["kilometrage"],
            boite_vitesse: doc.data()["boite_vitesse"],
            nombre_siege: doc.data()["nombre_siege"],
            nombre_roue: doc.data()["nombre_roue"],
            nombre_porte: doc.data()["nombre_porte"],
            annee: doc.data()["annee"],
            cylindre: doc.data()["cylindre"],
            image: doc.data()["image"],
            disponible: doc.data()["disponible"],
            uid: doc.data()["uid"],
            email: doc.data()["email"],
            phone: doc.data()["phone"],
            user_image: doc.data()["user_image"],
            fullName: doc.data()["fullName"],
            objet: doc.data()["objet"],
            type: doc.data()["type"],
            lieu: doc.data()['lieu'],
            code: doc.data()['code']
        )
    );
  })
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      routes: {
          Splash.id: (context) => Splash(),
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

class Splash extends StatefulWidget {
  static const String id = 'splash';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Splash();
  }
}

class _Splash extends State<Splash>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/logo.png',
        nextScreen: (currentFirebaseUser == null) ? LoginPage() : MainScreen(),
        splashTransition: SplashTransition.slideTransition,
        centered: true,
        backgroundColor: Colors.white);
  }

}