import 'package:car_rental_rdc/screen/book_car.dart';
import 'package:car_rental_rdc/widget/car_widget.dart';
import 'package:flutter/material.dart';

import 'models/data.dart';

class CustomSearchClass extends SearchDelegate{

  String type;
  CustomSearchClass({this.type});

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

    List list5;

    if(query == ''){

    } else {
      List list = donnees
          .where(
              (car) => car.objet.toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      List list2 = donnees
          .where(
              (car) => car.modele.toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      List list3 = donnees
          .where(
              (car) => car.marque.toString() == 'null' ?
          car.marque.toString().contains("a")
              : car.marque.toLowerCase()
              .contains(query.toLowerCase())
      ).toList();
      List list4 = donnees
          .where(
              (car) => car.code.toString().toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      list5 = list + list2 + list3 + list4;
    }
    return Container(
      child: GridView.count(
        physics: BouncingScrollPhysics(),
        childAspectRatio: 1 / 1.55,
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: list5.toString() == 'null' ? [] : list5.map((item) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookCar(car: item)),
                );
              },
              child: buildCar(item, null, context)
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List list5;

    if(query == ''){

    } else {
      List list = donnees
          .where(
              (car) => car.objet.toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      List list2 = donnees
          .where(
              (car) => car.modele.toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      List list3 = donnees
          .where(
              (car) => car.marque.toString() == 'null' ?
              car.marque.toString().contains("a")
                  : car.marque.toLowerCase()
              .contains(query.toLowerCase())
      ).toList();
      List list4 = donnees
          .where(
              (car) => car.code.toString().toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      list5 = list + list2 + list3 + list4;
    }

    return Container(
      child: GridView.count(
        physics: BouncingScrollPhysics(),
        childAspectRatio: 1 / 1.55,
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: list5.toString() == 'null' ? [] : list5.map((item) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookCar(car: item)),
                );
              },
              child: buildCar(item, null, context)
          );
        }).toList(),
      ),
    );
  }

}