import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';

Widget buildAccessoire(Vehicule dealer, int index, context){
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