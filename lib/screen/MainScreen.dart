import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/models/users.dart';
import 'package:car_rental_rdc/screen/Publication.dart';
import 'package:car_rental_rdc/screen/book_car.dart';
import 'package:car_rental_rdc/screen/serviceScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';
import '../search.dart';
import '../widget/car_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globalvariabels.dart';
import 'AddingElement.dart';
import 'LoginPage.dart';
import 'Modeles.dart';
import 'available_piece.dart';
import 'marque.dart';

class MainScreen extends StatefulWidget{
  static const String id = 'mainScreen';

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>{

  @override
  void initState() {
    // TODO: implement initState

    if(currentFirebaseUser != null){
      String userid = currentFirebaseUser.uid;

      FirebaseFirestore.instance.collection('Users').doc('${userid}').snapshots()
          .forEach((element) {
        setState(() {
          currentUser = Users(
              email: element.data()['email'],
              image: element.data()['image'],
              fullName: element.data()['name'],
              phone: element.data()['phone'],
              type: element.data()['type'],
              id: element.id
          );
        });
      });
    }
    super.initState();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TOKSMO AUTO",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: MediaQuery.of(context).size.width / 18
              ),
            ),
          ],
        ),
        actions: [
      Container(
      child: GestureDetector(
      onTap: (){
    showSearch(
    context: context,
    delegate: CustomSearchClass(type: 'types'),
    );
    },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ),
    ),
    )
        ]
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
                  /*UserAccountsDrawerHeader(
                    accountName: Text('${currentUser.fullName}', style: TextStyle(color: Colors.white),),
                    accountEmail: Text('${currentUser.email}', style: TextStyle(color: Colors.white)),
                    currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage('${currentUser.image}'),
                      ),

                    //onDetailsPressed: (){},


                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/car-rental-rdc.appspot.com/o/fundo.jpg?alt=media&token=537b483c-2065-43a7-9048-77345870d437"),
                        fit: BoxFit.cover)
                  ),),

                  Divider(),*/

                  currentUser != null ?
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
                        Navigator.pushNamed(context, AddingElement.id);
                      }
                  )
                  : Container(),

                  SizedBox(height: 5.0),

                  currentUser != null?
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
                            child: Center(child: Text('MODELES')),
                          )),
                      onTap: (){
                        Navigator.pushNamed(context, Modeles.id);
                      }
                  )
                      : Container(),

                  SizedBox(height: 5.0),

                  currentUser != null ?
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
                    )
                  : Container(),

                  ListTile(
                    title: Text("VENDRE"),
                    leading: Icon(FontAwesomeIcons.buysellads),
                    onTap: () async{
                      String response = url('+243893890266', 'Bonjour j\'aimerais vendre un article sur votre application.');
                      
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
                    title: Text("CONTACTEZ-NOUS", style: TextStyle(color: Colors.green,)),
                    leading: Icon(FontAwesomeIcons.whatsapp, color: Colors.green,),
                    onTap: () async{
                      String response = url('+243893890266', 'Bonjour, j\'ai besoin d\'information sur votre application.');
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                    },
                  ),

                  ListTile(
                    title: Text("CONTACTEZ-NOUS", style: TextStyle(color: Colors.grey,)),
                    leading: Icon(FontAwesomeIcons.phone, color: Colors.grey,),
                    onTap: () async{
                      String response = 'tel:+243893890266';
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                    },
                  ),

                  currentUser != null ?
                  ListTile(
                    title: Text('Déconnexion'),
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                      }
                    ) : Container(),


                ],
              ),
            ),
          ),

          Positioned(
                bottom: 5.0,
                left: 5.0,
                child: GestureDetector(
                  onTap: () async{
                    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                     String response = url('+243996852377', 'Bonjour Dominique Youness');
                      
                      if (await canLaunch(response)) {
                        await launch(response);
                      } else {
                        throw 'Could not launch $response';
                      }
                  },
                  child: Text(
                    "Version 1.0.0 \n by Dominique Youness\n www.domiyns.com",
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                )
              )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [

                    Text(
                      'VEHICULE',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    topVehicule(context, 'vehicule'),

                    topVehicule(context, 'engin'),

                    topVehicule(context, 'camion'),

                    topVehicule(context, 'location'),

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "PIECES",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          GestureDetector(
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AvailablePiece(type: 'piece',)),
                              );
                            },
                            child: Row(
                              children: [

                                Text(
                                  "Voir tout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),

                                SizedBox(
                                  width: 8,
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.width / 2.3,
                      margin: EdgeInsets.only(bottom: 5),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDealers(context, 'piece'),
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "ACCESSOIRES",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          GestureDetector(
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AvailablePiece(type: 'accessoire',)),
                              );
                            },
                            child: Row(
                              children: [

                                Text(
                                  "Voir tout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),

                                SizedBox(
                                  width: 8,
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.width / 2.3,
                      margin: EdgeInsets.only(bottom: 5),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDealers(context, 'accessoire'),
                      ),
                    ),


                    SizedBox(height: 5.0,),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget topVehicule(BuildContext context, type){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                type == 'vehicule' ? 'VOITURE' : '${type.toString().toUpperCase()} : ',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Marques(type: '$type',)),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Voir tout",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.width / 1.7,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: buildDeals(type),
          ),
        )
      ],
    );
  }

  List<Widget> buildDeals(String type){
    List<Widget> list = [];

    List<Vehicule> datas;

    if(type.toLowerCase() == 'location'){
      datas = donnees
          .where((donnees) => donnees.objet.toLowerCase().contains('$type'))
          .toList();
    } else {
      List<Vehicule> data = donnees
          .where((donnees) => donnees.type.toLowerCase().contains('$type'))
          .toList();
      datas = data.where((data) => data.objet.toLowerCase().contains('voiture'))
          .toList();
    }
    for (var i = 0; i < datas.length; i++) {
      list.add(
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookCar(car: datas[i])),
                );
              },
              child: buildCar(datas[i], i, context)
          )
      );
    }
    return list;
  }

  List<Widget> buildDealers(BuildContext context, type){
    List<Widget> list = [];
    List<Vehicule> datas = donnees
        .where((car) => car.objet.toLowerCase().contains('${type}'))
        .toList();
    for (var i = 0; i < datas.length; i++) {
      list.add(
          GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookCar(car: datas[i])),
                );
              },
              child: buildDealer(datas[i], i, context)
          )
      );
    }
    return list;
  }

  Widget buildDealer(Vehicule dealer, int index, context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(dealer.image[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 5,
          ),

          SizedBox(
            height: 16,
          ),

          Text(
            dealer.modele,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),

          Text(
            dealer.prix.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }

}