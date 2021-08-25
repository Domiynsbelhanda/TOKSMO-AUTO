import 'dart:io';

import 'package:car_rental_rdc/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_select/smart_select.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'models/data.dart';
import 'models/users.dart';

User currentFirebaseUser;

Users currentUser;

data() async {

  donnees.clear();

  Query collectionReference1 = await FirebaseFirestore.instance
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
            lieu: doc.data()['lieu']
        )
    );

  })
  );
}

var uuid = Uuid();

 String url(String phone, String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }


Widget buildIndicator(bool isActive){
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 6),
    height: 8,
    width: isActive ? 20 : 8,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.grey[400],
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  );
}

Widget buildSpecificationCar(String title, String data, context){
  return Container(
    width: MediaQuery.of(context).size.width / 4,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
    margin: EdgeInsets.only(right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        SizedBox(
          height: 2,
        ),

        Text(
          data,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width / 25,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    ),
  );
}

Widget contact(car, context){

   String response;

   return Container(
     decoration: BoxDecoration(
       color: Colors.grey[100],
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Padding(
           padding: EdgeInsets.only(left: 10.0),
           child: GestureDetector(
             onTap: () async{

               response = 'tel:${car.phone}';

               if (await canLaunch(response)) {
                 await launch(response);
               } else {
                 throw 'Could not launch $response';
               }
             },
             child: Row(children: [
               Icon(
                 FontAwesomeIcons.phone,
                 size: 20.0,
                 color: Colors.blue,
               ),

               SizedBox(width: 3.0,),

               Text(
                 "Appel",
                 style: TextStyle(
                   color: Colors.blue,
                   fontSize: 20,
                 ),
               )
             ],),
           ),
         ),

         Text(
           "Or",
           style: TextStyle(
             color: Colors.black,
             fontSize: 12,
           ),
         ),

         Padding(
           padding: EdgeInsets.only(left: 10.0),
           child: GestureDetector(
             onTap: () async{

               response = url(
                 car.phone, 
                 'Bonjour, je suis intéressé par votre véhicule ${car.marque}, ${car.modele} 《code ${car.code}》que vous vendez dans l\'application TOKSMO -AUTO');

               if (await canLaunch(response)) {
                 await launch(response);
               } else {
                 throw 'Could not launch $response';
               }
             },
             child: Row(children: [
               Icon(
                 FontAwesomeIcons.whatsapp,
                 size: 30.0,
                 color: Colors.green,
               ),

               SizedBox(width: 3.0,),

               Text(
                 "Whatsapp",
                 style: TextStyle(
                   color: Colors.green,
                   fontSize: 20,
                 ),
               )
             ],),
           ),
         ),
       ],
     ),
   );
}

Widget searching(context, types){
   return Container(
     child: GestureDetector(
       onTap: (){
         showSearch(
           context: context,
           delegate: CustomSearchClass(type: types),
         );
       },
       child: Padding(
         padding: EdgeInsets.all(5),
         child: Row(
           children: [
             Text('Rechercher'),
             IconButton(
               icon: Icon(
                 Icons.search,
               ),
             ),
           ],
         ),
       ),
     ),
   );
}


  List<S2Choice<String>> optionss = [
    S2Choice<String>(value: 'vehicule', title: 'VEHICULE'),
    S2Choice<String>(value: 'engin', title: 'ENGIN'),
    S2Choice<String>(value: 'camion', title: 'CAMION'),
    S2Choice<String>(value: 'location', title: 'LOCATION'),
    S2Choice<String>(value: 'piece', title: 'PIECE'),
    S2Choice<String>(value: 'accessoire', title: 'ACCESSOIRE'),
  ];