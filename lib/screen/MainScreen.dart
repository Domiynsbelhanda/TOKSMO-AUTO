import 'package:car_rental_rdc/location/available_cars.dart';
import 'package:car_rental_rdc/models/users.dart';
import 'package:car_rental_rdc/screen/Publication.dart';
import 'package:car_rental_rdc/screen/serviceScreen.dart';
import 'package:car_rental_rdc/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globalvariabels.dart';
import 'HomeScreen.dart';
import 'LoginPage.dart';

class MainScreen extends StatefulWidget{
  static const String id = 'mainScreen';

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String userid = currentFirebaseUser.uid;

    FirebaseFirestore.instance.collection('Users').doc('${userid}').snapshots()
        .forEach((element) {
      currentUser = Users(
        email: element.data()['email'],
        image: element.data()['image'],
        fullName: element.data()['name'],
        phone: element.data()['phone'],
        type: element.data()['type']
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        brightness: Brightness.dark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AUTO E-VOITURE",
              style: TextStyle(
                  color: Colors.black
              ),
            ),

            IconButton(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black,
                ),
                onPressed: (){})
          ],
        )
      ),
      drawer: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            color: Colors.white,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('${currentUser.fullName}', style: TextStyle(color: Colors.black),),
                    accountEmail: Text('${currentUser.email}', style: TextStyle(color: Colors.black)),
                    currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage('${currentUser.image}'),
                      ),

                    //onDetailsPressed: (){},


                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/car-rental-rdc.appspot.com/o/fundo.jpg?alt=media&token=537b483c-2065-43a7-9048-77345870d437"),
                        fit: BoxFit.cover)
                  ),),

                  Divider(),

                  '${currentUser.type.toLowerCase()}' != "admin"
                      ? Container()
                      :
                  GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('MARQUES')),
                          )),
                      onTap: (){
                        Navigator.pushNamed(context, PublicationPage.id);
                      }
                  ),

                  SizedBox(height: 5.0),

                  '${currentUser.type.toLowerCase()}' != "admin"
                  ? Container()
                  : 
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('PUBLIER')),
                      )),
                    onTap: (){
                      Navigator.pushNamed(context, PublicationPage.id);
                      }
                    ),

                  ListTile(
                    title: Text("VENDRE"),
                    leading: Icon(FontAwesomeIcons.buysellads),
                    onTap: () async{
                      String response = url('+243996852377', 'Bonjour j\'aimerais vendre un article sur votre application.');
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                    },
                  ),

                  ListTile(
                    title: Text("SERVICE"),
                    leading: Icon(FontAwesomeIcons.car),
                    onTap: (){
                      Navigator.pushNamed(context, ServiceScreen.id);
                    },
                  ),

                  ListTile(
                    title: Text("LOCATION"),
                    leading: Icon(FontAwesomeIcons.carSide),
                    onTap: (){
                      Navigator.pushNamed(context, AvailableLocation.id);
                    },
                  ),

                  ListTile(
                    title: Text("CONTACTEZ-NOUS", style: TextStyle(color: Colors.green,)),
                    leading: Icon(FontAwesomeIcons.whatsapp, color: Colors.green,),
                    onTap: () async{
                      String response = url('+243996852377', 'Bonjour, j\'ai besoin d\'information sur votre application.');
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                    },
                  ),

                  ListTile(
                    title: Text('Déconnexion'),
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                      }
                    ),


                ],
              ),
            ),
          ),

          Positioned(
                bottom: 5.0,
                left: 5.0,
                child: GestureDetector(
                  onTap: () async{
                     String response = url('+243996852377', 'Bonjour Dominique Youness');
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                  },
                  child: Text(
                    "Version 1.0.0 \n by Dominique Youness\n +243 996 852 377",
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                )
              )
        ],
      ),
      body: HomeScreen(),
    );
  }

}