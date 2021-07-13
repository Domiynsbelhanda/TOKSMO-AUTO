import 'package:car_rental_rdc/Nouveau%20dossier/book_car.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/car_widget.dart';
import 'package:car_rental_rdc/engin/book_car.dart';
import 'package:car_rental_rdc/engin/car_widget.dart';
import 'package:car_rental_rdc/track/book_car.dart';
import 'package:car_rental_rdc/track/car_widget.dart';
import 'package:flutter/material.dart';

import 'location/book_car.dart';
import 'location/car_widget.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/book_piece.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/book_accessoire.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/accessoire_widget.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/dealer_widget.dart';

import 'models/data.dart';

class CustomSearchClass extends SearchDelegate{

  List listing;
  String type;
  CustomSearchClass({this.listing, this.type});

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return SafeArea(
      child: Column(
        children: [
          type == 'car' ? vehicules(context, query, donnees, type)
              : type == 'engin' ? engins(context, query, donnees, type)
              : type == 'track' ? tracks(context, query, donnees, type)
              : type == 'location' ? location(context, query, donnees, type)
              : type == 'piece' ? piecess(context, query, donnees, type)
              : type == 'accessoire' ? accessoires(context, query, donnees, type) : null
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // you can use this method to show suggestions before the user start search or to view a real time search results as we will show later
    return SafeArea(
      child: Column(
        children: [
          Text("$type : "),
          type == 'car' ? vehicules(context, query, donnees, type)
              : type == 'engin' ? engins(context, query, donnees, type)
              : type == 'track' ? tracks(context, query, donnees, type)
              : type == 'location' ? location(context, query, donnees, type)
              : type == 'piece' ? piecess(context, query, donnees, type)
              : type == 'accessoire' ? accessoires(context, query, donnees, type) : null
        ],
      ),
    );
  }

}

Widget location(context, querys, List<Vehicule> liste, type){

  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Location(car: item)
                ),
              );
            },
            child: buildLocations(item, null, context)
        );
      }).toList(),
    ),
  );
}

Widget engins(context, querys, List<Vehicule> liste, type){


  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookEngin(car: item)
                ),
              );
            },
            child: buildEngin(item, null, context)
        );
      }).toList(),
    ),
  );
}

Widget tracks(context, querys, List<Vehicule> liste, type){

  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookTrack(car: item)
                ),
              );
            },
            child: buildTrack(item, null, context)
        );
      }).toList(),
    ),
  );
}

Widget vehicules(context, querys, List<Vehicule> liste, type){

  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookCar(car: item)
                ),
              );
            },
            child: buildCar(item, null, context)
        );
      }).toList(),
    ),
  );
}

Widget piecess(context, querys, List<Vehicule> liste, type){

  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookPiece(car: item)
                ),
              );
            },
            child: buildDealer(item, null, context)
        );
      }).toList(),
    ),
  );
}

Widget accessoires(context, querys, List<Vehicule> liste, type){

  return Expanded(
    child: GridView.count(
      physics: BouncingScrollPhysics(),
      childAspectRatio: 1 / 1.55,
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: liste
          .where((car) => car.marque.toLowerCase().contains(querys.toString().toLowerCase()))
          .toList().map((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookAccessoire(car: item)
                ),
              );
            },
            child: buildAccessoire(item, null, context)
        );
      }).toList(),
    ),
  );
}