import 'package:car_rental_rdc/constants.dart';
import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';

Widget buildCar(Vehicule car, int index, context){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
    margin: EdgeInsets.only(right: index != null ? MediaQuery.of(context).size.width / 25 : 0, left: index == 0 ? MediaQuery.of(context).size.width / 25   : 0),
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      car.prix,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ),

        SizedBox(
          height: 3,
        ),

        Container(
          height: MediaQuery.of(context).size.width / 3.5,
          child: Center(
            child: Image.asset(
              car.image[0],
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.width / 35,
        ),

        Text(
          car.marque,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 25
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              car.modele,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 23,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),

            Text(
              "Detail",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 30
              ),
            ),
          ],
        ),

      ],
    ),
  );
}