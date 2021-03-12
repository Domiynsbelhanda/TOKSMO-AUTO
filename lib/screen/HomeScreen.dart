import 'package:car_rental_rdc/Nouveau%20dossier/accessoire_widget.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/available_accessoire.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/available_cars.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/available_piece.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/book_accessoire.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/book_car.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/book_piece.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/car_widget.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/dealer_widget.dart';
import 'package:car_rental_rdc/engin/available_cars.dart';
import 'package:car_rental_rdc/engin/book_car.dart';
import 'package:car_rental_rdc/location/car_widget.dart';
import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/screen/marque.dart';
import 'package:car_rental_rdc/location/book_car.dart';
import 'package:car_rental_rdc/track/book_car.dart';
import 'package:car_rental_rdc/track/car_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_rdc/engin/car_widget.dart';

import '../constants.dart';
import '../search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  List<Vehicule> cars = getVehiculeList();
  List<Engin> engin = getEnginList();
  List<Track> track = getTrackList();
  List<Camion> camion = getCamionList();
  List<Piece> piece = getPieceList();
  List<Accessoire> accessoire = getAccessoireList();

  @override
  void initState() {
    super.initState();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

                    topVehicule(context),

                    topEngin(context),

                    topTrack(context),

                    topLocation(context),

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
                              Navigator.pushNamed(context, AvailablePiece.id);
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
                        children: buildDealers(context),
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
                              Navigator.pushNamed(context, AvailableAccessoire.id);
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
                        children: buildAccessoires(context),
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

  List<Widget> buildDeals(){
    List<Widget> list = [];
    for (var i = 0; i < cars.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AvailableCars(type: cars[i].marque,)),
            );
          },
          child: buildCar(cars[i], i, context)
        )
      );
    }
    return list;
  }

  Widget topVehicule(BuildContext context){
    return Column(
      children: [

        Text(
                      "VEHICULES",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Voiture :",
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
                    MaterialPageRoute(builder: (context) => Marques(type: 'car',)),
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
            children: buildDeals(),
          ),
        )
      ],
    );
  }

  Widget topEngin(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Engin :",
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
                    MaterialPageRoute(builder: (context) => Marques(type: 'engin',)),
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
            children: buildEngins(),
          ),
        )
      ],
    );
  }

  Widget topTrack(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Camion",
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
                    MaterialPageRoute(builder: (context) => Marques(type: 'track',)),
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
            children: buildTracks(),
          ),
        )
      ],
    );
  }

  List<Widget> buildEngins(){
    List<Widget> list = [];
    for (var i = 0; i < engin.length; i++) {
      list.add(
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AvailableEngin(type: engin[i].marque)),
                );
              },
              child: buildEngin(engin[i], i, context)
          )
      );
    }
    return list;
  }

  List<Widget> buildTracks(){
    List<Widget> list = [];
    for (var i = 0; i < track.length; i++) {
      list.add(
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookTrack(car: track[i])),
                );
              },
              child: buildTrack(track[i], i, context)
          )
      );
    }
    return list;
  }

  List<Widget> buildDealers(BuildContext context){
    List<Widget> list = [];
    for (var i = 0; i < piece.length; i++) {
      list.add(
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookPiece(car: piece[i])),
              );
            },
              child: buildDealer(piece[i], i, context)
          )
      );
    }
    return list;
  }

  List<Widget> buildAccessoires(BuildContext context){
    List<Widget> list = [];
    for (var i = 0; i < accessoire.length; i++) {
      list.add(
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookAccessoire(car: accessoire[i])),
              );
            },
              child: buildAccessoire(accessoire[i], i, context)
          )
      );
    }
    return list;
  }


  Widget topLocation(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location :",
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
                    MaterialPageRoute(builder: (context) => Marques(type: 'location',)),
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
            children: buildLocation(),
          ),
        )
      ],
    );
  }

  List<Widget> buildLocation(){
    List<Widget> list = [];
    for (var i = 0; i < camion.length; i++) {
      list.add(
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Location(car: camion[i])),
                );
              },
              child: buildLocations(camion[i], i, context)
          )
      );
    }
    return list;
  }
}